import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Animation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation colorAnimation;
  late Animation sizeAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    // colorAnimation =
    //     ColorTween(begin: Colors.blue, end: Colors.yellow).animate(controller);
    colorAnimation = ColorTween(begin: Colors.blue, end: Colors.yellow)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
    sizeAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(controller);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  void _restartAnimation() {
    controller.reset();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Animation"),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: sizeAnimation.value,
              width: sizeAnimation.value,
              color: colorAnimation.value,
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.black26,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  _restartAnimation();
                },
                icon: Icon(Icons.refresh_outlined)),
          ],
        ),
      ),
    );
  }
}
