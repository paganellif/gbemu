import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import './cpu/cpu.dart';
import './memory/cartridge.dart';
import './config.dart';
import 'emulator_state.dart';

/// Main emulator object used to directly interact with the system.
///
/// GUI communicates with this object, it is responsible for providing image, handling key input and user interaction.
class Emulator {
  /// State of the emulator, indicates if there is data loaded, and the emulation state.
  EmulatorState state = EmulatorState.WAITING;

  /// CPU object
  CPU? cpu;

  /// Press a gamepad button down (update memory register).
  void buttonDown(int button) {
    cpu?.buttons[button] = true;
  }

  /// Release a gamepad button (update memory register).
  void buttonUp(int button) {
    cpu?.buttons[button] = false;
  }

  /// Load a ROM from a file and create the HW components for the emulator.
  void loadROM(Uint8List data) {
    if (state != EmulatorState.WAITING) {
      if (kDebugMode) {
        print('Emulator should be reset to load ROM.');
      }
      return;
    }

    Cartridge cartridge = Cartridge(data);

    cpu = CPU(cartridge: cartridge);
    cpu?.reset();

    state = EmulatorState.READY;

    printCartridgeInfo();
  }

  /// Print some information about the ROM file loaded into the emulator.
  void printCartridgeInfo() {
    if (kDebugMode) {
      print('Catridge info\nType: ${
          cpu?.cartridge.type
      }\nName: ${cpu?.cartridge.name}\nGB: ${
          cpu?.cartridge.gameboyType
      }\nSGB: ${cpu?.cartridge.superGameboy}');
    }
  }

  /// Reset the emulator, stop running the code and unload the cartridge
  void reset() {
    cpu = null;
    state = EmulatorState.WAITING;
  }

  /// Do a single step in the cpu, set it to debug mode, step and then reset.
  void debugStep() {
    if (state != EmulatorState.READY) {
      if (kDebugMode) {
        print('Emulator not ready, cannot step.');
      }
      return;
    }

    bool wasDebug = Config.debugInstructions;
    Config.debugInstructions = true;
    cpu?.step();
    Config.debugInstructions = wasDebug;
  }

  /// Run the emulation all full speed.
  void run() {
    if (state != EmulatorState.READY) {
      if (kDebugMode) {
        print('Emulator not ready, cannot run.');
      }
      return;
    }

    state = EmulatorState.RUNNING;

    int frequency = CPU.FREQUENCY ~/ 4;
    double periodCPU = 1e6 / frequency;

    int fps = 30;
    double periodFPS = 1e6 / fps;

    int cycles = periodFPS ~/ periodCPU;
    Duration period = Duration(microseconds: periodFPS.toInt());

    loop() async {
      while (true) {
        if (state != EmulatorState.RUNNING) {
          if (kDebugMode) {
            print('Stopped emulation.');
          }
          return;
        }

        try {
          for (var i = 0; i < cycles; i++) {
            cpu?.step();
          }
        } catch (e, stacktrace) {
          if (kDebugMode) {
            print('Error occured, emulation stoped.\n$e\n$stacktrace');
          }
          return;
        }

        await Future.delayed(period);
      }
    }

    loop();
  }

  /// Pause the emulation
  void pause() {
    if (state != EmulatorState.RUNNING) {
      if (kDebugMode) {
        print('Emulator not running cannot be paused');
      }
      return;
    }

    state = EmulatorState.READY;
  }
}
