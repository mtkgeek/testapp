import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// App entry point
class MyApp extends StatelessWidget {
  /// Constructor
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

/// Home screen widget
class MyHomePage extends StatefulWidget {
  /// Constructor
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Random _random = Random();
  final int _hexLength = 6;
  final double _primaryFontSize = 24.0;
  final double _luminanceThreshold = 0.5;
  Color? _randomBackgroundColor;

  void _changeColor() {
    setState(() {
      // Generate a random 24-bit number, then convert it to a 6-digit
      //hex string
      String hexColor = _random.nextInt(0xFFFFFF).toRadixString(16);

      // Pad the left side with zeros to ensure it's always 6 digits long
      hexColor = hexColor.padLeft(_hexLength, '0');

      // Convert the hex string back to a Color object
      _randomBackgroundColor = Color(int.parse('0xFF$hexColor'));
    });
  }

  Color getTextColorBasedOnBackground(Color backgroundColor) {
    final double luminance = 0.2126 * backgroundColor.red / 255 +
        0.7152 * backgroundColor.green / 255 +
        0.0722 * backgroundColor.blue / 255;

    return luminance < _luminanceThreshold ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("TestApp"),
      ),
      body: GestureDetector(
        onTap: _changeColor,
        child: ColoredBox(
          color: _randomBackgroundColor ?? Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hello World',
                  style: TextStyle(
                    fontSize: _primaryFontSize,
                    fontWeight: FontWeight.w600,
                    color: getTextColorBasedOnBackground(
                      _randomBackgroundColor ?? Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
