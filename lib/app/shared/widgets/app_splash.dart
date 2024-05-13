import 'package:flutter/material.dart';

class AppSplash extends StatelessWidget {
  const AppSplash({super.key});

  /// The splash duration to wait. Called once.
  static final future = Future.delayed(const Duration(seconds: 3));

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Center(
          child: Text('Splash Page'),
        ),
      ),
    );
  }
}
