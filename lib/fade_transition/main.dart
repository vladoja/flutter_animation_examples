import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const FadeTransitionExampleApp());
}

class FadeTransitionExampleApp extends StatelessWidget {
  const FadeTransitionExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fade Transition Example',
      home: const FadeTransitionExample(),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 154, 199, 221)),
    );
  }
}

class FadeTransitionExample extends StatefulWidget {
  const FadeTransitionExample({super.key});

  @override
  State<FadeTransitionExample> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FadeTransitionExample>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fade Transition Example'),
        centerTitle: true,
      ),
      body: Center(
        child: FadeTransition(
          opacity: animation,
          child: Container(
            width: 80,
            height: 80,
            color: Color.fromARGB(255, 107, 28, 107),
          ),
        ),
      ),
    );
  }
}
