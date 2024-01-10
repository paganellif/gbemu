import 'dart:math';
import 'package:flutter/foundation.dart';

import '../cpu/cpu.dart';
import '../gameboy_type.dart';
import './mmu/mmu.dart';
import './mmu/mbc1.dart';
import './mmu/mbc2.dart';
import './mmu/mbc3.dart';
import './mmu/mbc5.dart';
import 'cartridge_type.dart';

/// Stores the cartridge information and data.
///
/// Also manages the cartridge type and is responsible for the memory bank switching.
class Cartridge {
  /// Data stored in the cartridge (directly loaded from a ROM file).
  late List<int> data;

  /// Size of the memory in bytes
  int size = 0;

  /// Cartridge name read from the
  late String name;

  /// Cartridge type, there are 16 different types.
  ///
  /// Read from memory address 0x147 (Check page 11 of the GB CPU manual for details)
  int type = 0;

  /// In cartridge ROM configuration. Read from the address 0x148.
  ///
  /// (Check page 12 of the GB CPU manual for details)
  int romType = 0;

  /// Indicates how many rom banks there are available.
  ///
  /// Each ROM bank has 32KB in size
  int romBanks = 0;

  /// In cartridge RAM configuration. Read from the address 0x149.
  ///
  /// (Check page 12 of the GB CPU manual for details)
  int ramType = 0;

  /// Indicates how many RAM banks are available in the cartridge.
  ///
  /// Each bank has 8KBytes in size.
  int ramBanks = 0;

  /// Cartridge checksum, used to check if the data of the game is good, and also used to select the better color palette in classic gb games.
  int checksum = 0;

  /// In CGB cartridges the upper bit is used to enable CGB functions. This is required, otherwise the CGB switches itself into Non-CGB-Mode.
  ///
  /// There are two different CGB modes 80h Game supports CGB functions, but works on old gameboys also, C0h Game works on CGB only.
  late GameboyType gameboyType;

  /// SGB mode indicates if the game has super gameboy features
  late bool superGameboy;

  Cartridge(List<int> inputData) {
    /// Load cartridge byte data
    size = inputData.length;
    data = inputData;

    type = readByte(0x147);
    name = String.fromCharCodes(readBytes(0x134, 0x142));
    romType = readByte(0x148);
    ramType = readByte(0x149);
    gameboyType =
        readByte(0x143) == 0x80 ? GameboyType.COLOR : GameboyType.CLASSIC;
    superGameboy = readByte(0x146) == 0x3;

    // Calculate the special value used by the CGB boot ROM to colorize some monochrome games.
    int chk = 0;
    for (int i = 0; i < 16; i++) {
      chk += data[0x134 + i];
    }
    checksum = chk & 0xFF;

    setBankSizeRAM();
    setBankSizeROM();
  }

  /// Create a the memory controller of the cartridge.
  MMU? createController(CPU cpu) {
    if (type == CartridgeType.ROM) {
      if (kDebugMode) {
        print('Created basic MMU unit.');
      }
      return MMU(cpu);
    } else if (type == CartridgeType.MBC1 ||
        type == CartridgeType.MBC1_RAM ||
        type == CartridgeType.MBC1_RAM_BATT) {
      if (kDebugMode) {
        print('Created MBC1 unit.');
      }
      return MBC1(cpu);
    } else if (type == CartridgeType.MBC2 ||
        type == CartridgeType.MBC2_BATT) {
      if (kDebugMode) {
        print('Created MBC2 unit.');
      }
      return MBC2(cpu);
    } else if (type == CartridgeType.MBC3 ||
        type == CartridgeType.MBC3_RAM ||
        type == CartridgeType.MBC3_RAM_BATT ||
        type == CartridgeType.MBC3_TIMER_BATT ||
        type == CartridgeType.MBC3_TIMER_RAM_BATT) {
      if (kDebugMode) {
        print('Created MBC3 unit.');
      }
      return MBC3(cpu);
    } else if (type == CartridgeType.MBC5 ||
        type == CartridgeType.MBC5_RAM ||
        type == CartridgeType.MBC5_RAM_BATT ||
        type == CartridgeType.MBC5_RUMBLE ||
        type == CartridgeType.MBC5_RUMBLE_SRAM ||
        type == CartridgeType.MBC5_RUMBLE_SRAM_BATT) {
      if (kDebugMode) {
        print('Created MBC5 unit.');
      }
      return MBC5(cpu);
    }

    return null;
  }

  /// Checks if the cartridge has a internal battery to keep the RAM state.
  bool hasBattery() {
    return type == CartridgeType.ROM_RAM_BATT ||
        type == CartridgeType.ROM_MMM01_SRAM_BATT ||
        type == CartridgeType.MBC1_RAM_BATT ||
        type == CartridgeType.MBC3_TIMER_BATT ||
        type == CartridgeType.MBC3_TIMER_RAM_BATT ||
        type == CartridgeType.MBC3_RAM_BATT ||
        type == CartridgeType.MBC5_RAM_BATT ||
        type == CartridgeType.MBC5_RUMBLE_SRAM_BATT;
  }

  /// Set how many ROM banks exist based on the ROM type.
  void setBankSizeROM() {
    if (romType == 52) {
      romBanks = 72;
    } else if (romType == 53) {
      romBanks = 80;
    } else if (romType == 54) {
      romBanks = 96;
    } else {
      romBanks = (pow(2, romType + 1)).toInt();
    }
  }

  /// Set how many RAM banks exist in the cartridge based on the RAM type.
  void setBankSizeRAM() {
    if (ramType == 0) {
      ramBanks = 0;
    } else if (ramType == 1) {
      ramBanks = 1;
    } else if (ramType == 2) {
      ramBanks = 1;
    } else if (ramType == 3) {
      ramBanks = 4;
    } else if (ramType == 4) {
      ramBanks = 16;
    }
  }

  /// Read a range of bytes from the cartridge.
  List<int> readBytes(int initialAddress, int finalAddress) {
    return data.sublist(initialAddress, finalAddress);
  }

  /// Read a single byte from cartridge
  int readByte(int address) {
    return data[address] & 0xFF;
  }
}
