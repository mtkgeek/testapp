import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

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
      // Generate a random 24-bit number, then convert it to a 6-digit hex string
      String hexColor = _random.nextInt(0xFFFFFF).toRadixString(16);

      // Pad the left side with zeros to ensure it's always 6 digits long
      hexColor = hexColor.padLeft(_hexLength, '0');

      // Convert the hex string back to a Color object
      _randomBackgroundColor = Color(int.parse('0xFF$hexColor'));
    });
  }

  Color getTextColorBasedOnBackground(Color backgroundColor) {
    double luminance = 0.2126 * backgroundColor.red / 255 +
        0.7152 * backgroundColor.green / 255 +
        0.0722 * backgroundColor.blue / 255;

    return luminance < _luminanceThreshold ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
