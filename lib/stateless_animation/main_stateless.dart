import 'package:flutter/material.dart';

const kSelectedColor = Colors.blueAccent;
const kUnselectedColor = Colors.transparent;
const kSelectedShadowOffset = Offset(0.0, 4.0);
final kSelectedBorderRadius = BorderRadius.circular(32.0);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: DecoratedBoxTransitionExample(),
        ),
      ),
    );
  }
}

class DecoratedBoxTransitionExample extends StatefulWidget {
  const DecoratedBoxTransitionExample({super.key});

  @override
  State<DecoratedBoxTransitionExample> createState() =>
      _DecoratedBoxTransitionExampleState();
}

class _DecoratedBoxTransitionExampleState
    extends State<DecoratedBoxTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isSelected = false;

  final DecorationTween decorationTween = DecorationTween(
    end: BoxDecoration(
      color: kSelectedColor.withAlpha(32),
      borderRadius: kSelectedBorderRadius,
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: kSelectedColor.withOpacity(0.2),
            blurRadius: 8.0,
            offset: kSelectedShadowOffset)
      ],
    ),
    begin: BoxDecoration(
      color: kUnselectedColor,
      borderRadius: kSelectedBorderRadius,
      // No shadow.
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: DecoratedBoxTransition(
        position: DecorationPosition.background,
        decoration: decorationTween.animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
        child: Container(
          width: 200,
          height: 200,
          child: Center(
            child: Text(
              "Content",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: kSelectedColor),
            ),
          ),
        ),
      ),
    );
  }

  void _handleTap() {
    _isSelected ? _controller.reverse() : _controller.forward();
    setState(() {
      _isSelected = !_isSelected;
    });
  }
}
