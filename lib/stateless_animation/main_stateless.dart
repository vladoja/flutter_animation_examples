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
          child: RootStatefulWidget(),
        ),
      ),
    );
  }
}

class RootStatefulWidget extends StatefulWidget {
  const RootStatefulWidget({super.key});

  @override
  State<RootStatefulWidget> createState() {
    return _RootState();
  }
}

class _RootState extends State<RootStatefulWidget> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return DecoratedBoxTransitionExample(
      isSelected: _isSelected,
      onSelectionChanged: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class DecoratedBoxTransitionExample extends StatelessWidget {
  final bool isSelected;
  final void Function() onSelectionChanged;

  const DecoratedBoxTransitionExample(
      {super.key, required this.isSelected, required this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelectionChanged,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            color: isSelected ? kSelectedColor.withAlpha(32) : kUnselectedColor,
            borderRadius: BorderRadius.circular(32),
            boxShadow: isSelected
                ? <BoxShadow>[
                    BoxShadow(
                        color: kSelectedColor.withOpacity(0.2),
                        blurRadius: 8.0,
                        offset: kSelectedShadowOffset)
                  ]
                : []),
        // child: const MyWidget(),
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
    );
  }
}
