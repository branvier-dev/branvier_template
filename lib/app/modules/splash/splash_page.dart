import 'package:branvier/branvier.dart';
import 'package:flutter/material.dart';

///The widget to show while app is loading.
class SplashLoader extends StatelessWidget {
  const SplashLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Placeholder()
              .scale(0.9, end: 1.1, onComplete: (ac) => ac.repeat()),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
