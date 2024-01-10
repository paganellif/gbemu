import 'package:flutter/material.dart';

import 'gui/main_screen.dart';

void main() {
  runApp(const GBEmu());
}

class GBEmu extends StatelessWidget {
  const GBEmu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GBC',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MainScreen(title: 'GBC'),
        debugShowCheckedModeBanner: true,
        showPerformanceOverlay: false,
        showSemanticsDebugger: false,
        debugShowMaterialGrid: false
    );
  }
}
