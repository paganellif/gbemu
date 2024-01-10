import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gbemu/emulator/emulator_state.dart';
import 'package:gbemu/emulator/memory/gamepad.dart';
import 'package:gbemu/emulator/emulator.dart';
import 'package:gbemu/gui/lcd.dart';
import 'package:gbemu/gui/button.dart';
import 'package:gbemu/gui/modal.dart';

import '../emulator/config.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});

  final String title;

  /// Emulator instance
  static Emulator emulator = Emulator();
  static LCDState lcdState = LCDState();
  static bool keyboardHandlerCreated = false;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const int KEY_I = 73;
  static const int KEY_O = 79;
  static const int KEY_P = 80;

  static Map<int, int> keyMapping = {
    // Left arrow
    263: Gamepad.LEFT,
    // Right arrow
    262: Gamepad.RIGHT,
    // Up arrow
    265: Gamepad.UP,
    // Down arrow
    264: Gamepad.DOWN,
    // Z
    90: Gamepad.A,
    // X
    88: Gamepad.B,
    // Enter
    257: Gamepad.START,
    // C
    67: Gamepad.SELECT
  };

  @override
  Widget build(BuildContext context) {
    if (!MainScreen.keyboardHandlerCreated) {
      MainScreen.keyboardHandlerCreated = true;

      RawKeyboard.instance.addListener((RawKeyEvent key) {
        // Get the keyCode from the object string description (keyCode does not seem to be exposed other way)
        String keyPress = key.data.toString();

        String value = keyPress.substring(
            keyPress.indexOf('keyCode: ') + 9, keyPress.indexOf(', scanCode:'));
        if (value.isEmpty) {
          return;
        }

        int keyCode = int.parse(value);

        // Debug functions
        if (MainScreen.emulator.state == EmulatorState.RUNNING) {
          if (key is RawKeyDownEvent) {
            if (keyCode == KEY_I) {
              if (kDebugMode) {
                print('Toggle background layer.');
              }
              Config.drawBackgroundLayer = !Config.drawBackgroundLayer;
            } else if (keyCode == KEY_O) {
              if (kDebugMode) {
                print('Toggle sprite layer.');
              }
              Config.drawSpriteLayer = !Config.drawSpriteLayer;
            }
          }
        }

        if (!keyMapping.containsKey(keyCode)) {
          return;
        }

        if (key is RawKeyUpEvent) {
          MainScreen.emulator.buttonUp(keyMapping[keyCode]!);
        } else if (key is RawKeyDownEvent) {
          MainScreen.emulator.buttonDown(keyMapping[keyCode]!);
        }
      });
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // LCD
              const Expanded(child: LCDWidget()),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    // Buttons (DPAD + AB)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // DPAD
                        Column(
                          children: <Widget>[
                            Button(
                                color: Colors.blueAccent,
                                onPressed: () {
                                  MainScreen.emulator.buttonDown(Gamepad.UP);
                                },
                                onReleased: () {
                                  MainScreen.emulator.buttonUp(Gamepad.UP);
                                },
                                label: "Up"),
                            Row(children: <Widget>[
                              Button(
                                  color: Colors.blueAccent,
                                  onPressed: () {
                                    MainScreen.emulator
                                        .buttonDown(Gamepad.LEFT);
                                  },
                                  onReleased: () {
                                    MainScreen.emulator.buttonUp(Gamepad.LEFT);
                                  },
                                  label: "Left"),
                              const SizedBox(width: 50, height: 50),
                              Button(
                                  color: Colors.blueAccent,
                                  onPressed: () {
                                    MainScreen.emulator
                                        .buttonDown(Gamepad.RIGHT);
                                  },
                                  onReleased: () {
                                    MainScreen.emulator.buttonUp(Gamepad.RIGHT);
                                  },
                                  label: "Right")
                            ]),
                            Button(
                                color: Colors.blueAccent,
                                onPressed: () {
                                  MainScreen.emulator.buttonDown(Gamepad.DOWN);
                                },
                                onReleased: () {
                                  MainScreen.emulator.buttonUp(Gamepad.DOWN);
                                },
                                label: "Down"),
                          ],
                        ),
                        // AB
                        Column(
                          children: <Widget>[
                            Button(
                                color: Colors.red,
                                onPressed: () {
                                  MainScreen.emulator.buttonDown(Gamepad.A);
                                },
                                onReleased: () {
                                  MainScreen.emulator.buttonUp(Gamepad.A);
                                },
                                label: "A"),
                            Button(
                                color: Colors.green,
                                onPressed: () {
                                  MainScreen.emulator.buttonDown(Gamepad.B);
                                },
                                onReleased: () {
                                  MainScreen.emulator.buttonUp(Gamepad.B);
                                },
                                label: "B"),
                          ],
                        ),
                      ],
                    ),
                    // Button (SELECT + START)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Button(
                            color: Colors.orange,
                            onPressed: () {
                              MainScreen.emulator.buttonDown(Gamepad.START);
                            },
                            onReleased: () {
                              MainScreen.emulator.buttonUp(Gamepad.START);
                            },
                            labelColor: Colors.black,
                            label: "Start"),
                        Container(width: 20),
                        Button(
                            color: Colors.yellowAccent,
                            onPressed: () {
                              MainScreen.emulator.buttonDown(Gamepad.SELECT);
                            },
                            onReleased: () {
                              MainScreen.emulator.buttonUp(Gamepad.SELECT);
                            },
                            labelColor: Colors.black,
                            label: "Select"),
                      ],
                    ),
                    // Button (Start + Pause + Load)
                    Expanded(
                        child: ListView(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        TextButton(
                            onPressed: () {
                              if (MainScreen.emulator.state !=
                                  EmulatorState.READY) {
                                Modal.alert(context, 'Error',
                                    'Not ready to run. Load ROM first.',
                                    onCancel: () {});
                                return;
                              }
                              MainScreen.emulator.run();
                            },
                            //color: Colors.black,
                            child: const Text('Run',
                                style: TextStyle(color: Colors.white))),
                        TextButton(
                            onPressed: () {
                              if (MainScreen.emulator.state !=
                                  EmulatorState.RUNNING) {
                                Modal.alert(context, 'Error',
                                    'Not running cant be paused.',
                                    onCancel: () {});
                                return;
                              }

                              MainScreen.emulator.pause();
                            },
                            //color: Colors.black,
                            child: const Text('Pause',
                                style: TextStyle(color: Colors.white))),
                        TextButton(
                            onPressed: () {
                              MainScreen.emulator.reset();
                            },
                            //color: Colors.black,
                            child: const Text('Reset',
                                style: TextStyle(color: Colors.white))),
                        TextButton(
                            onPressed: () {
                              MainScreen.emulator.debugStep();
                            },
                            //color: Colors.black,
                            child: const Text('Step',
                                style: TextStyle(color: Colors.white))),
                        TextButton(
                            onPressed: () {
                              if (MainScreen.emulator.state !=
                                  EmulatorState.WAITING) {
                                Modal.alert(context, 'Error',
                                    'There is a ROM already loaded. Reset before loading ROM.',
                                    onCancel: () {});
                                return;
                              }

                              FilePicker.platform
                                  .pickFiles(dialogTitle: 'Choose ROM')
                                  .then((FilePickerResult? result) {
                                    print(result);

                                    if (result != null && result.files.single.bytes!.isNotEmpty) {
                                      MainScreen.emulator
                                          .loadROM(result.files.single.bytes!);
                                    } else {
                                      Modal.alert(
                                          context, 'Error', 'No file was selected.',
                                          onCancel: () {});
                                    }
                              });

                              if (MainScreen.emulator.state ==
                                  EmulatorState.READY) {
                                Modal.alert(context, 'Success',
                                    'ROM loaded, ready to play.',
                                    onCancel: () {});
                              }
                            },
                            //color: Colors.black,
                            child: const Text("Load",
                                style: TextStyle(color: Colors.white))),
                      ],
                    ))
                  ]))
            ]));
  }

  /// Show a text input dialog to introduce string values.
  textInputDialog({required String hint, required Function onOpen}) async {
    TextEditingController controller = TextEditingController();
    controller.text = hint;

    await showDialog<String>(
        context: context,
        builder: (BuildContext cx) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(16.0),
              content: Row(children: <Widget>[
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'File Name'),
                  ),
                )
              ]),
              actions: <Widget>[
                Button(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: 'Cancel',
                  color: Colors.yellowAccent,
                  onReleased: () {},
                ),
                TextButton(
                    child: const Text('Open'),
                    onPressed: () {
                      onOpen(controller.text);
                      Navigator.pop(context);
                    })
              ]);
        });
  }
}
