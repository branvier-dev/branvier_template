import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// Get instance of [HomeController].
  HomeController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    // final count = context.select(() => controller.counter);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: controller.onIncrement,
          child: RxBuilder(
            builder: (_) => Text(controller.count),
          ),
        ),
      ),
    );
  }
}
