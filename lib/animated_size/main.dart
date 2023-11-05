import 'package:flutter/material.dart';

// AnimatedSize is BROKEN.
// https://stackoverflow.com/questions/59132930/flutter-animatedsize-works-in-one-direction-only
void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 154, 199, 221),
      ),
      home: const AnimatedSizeExample(),
    );
  }
}

class AnimatedSizeExample extends StatefulWidget {
  const AnimatedSizeExample({super.key});

  @override
  State<AnimatedSizeExample> createState() => _AnimatedSizeExampleState();
}

class _AnimatedSizeExampleState extends State<AnimatedSizeExample>
    with SingleTickerProviderStateMixin {
  double _height = 80;
  double _width = 80;
  final double _basicIncrement = 20;
  double _increment = 20;
  double _multiplier = 2;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    debugPrint('Screen height: $screenHeight');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Size Example'),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            debugPrint(
                'Taped. Increment: $_increment. Multiplier: $_multiplier');
            _increment = _increment.abs() * _multiplier;

            if (_height + _increment > screenHeight) {
              _multiplier = -0.5;
              _increment *= _multiplier;
            } else if (_increment.abs() <= _basicIncrement) {
              _multiplier = 2;
              _increment *= _multiplier;
            }

            setState(() {
              _height += _increment;
              _width += _increment;
            });
          },
          child: AnimatedSize(
            duration: const Duration(milliseconds: 500),
            curve: (_multiplier > 0)
                ? Curves.bounceOut
                : Curves.fastLinearToSlowEaseIn,
            reverseDuration: const Duration(milliseconds: 1000),
            child: Container(
              width: _width,
              height: _height,
              color: const Color.fromARGB(255, 107, 28, 107),
            ),
          ),
        ),
      ),
    );
  }
}
