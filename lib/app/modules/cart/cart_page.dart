import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'cart_controller.dart';

///[CartPage] is a view controlled by [CartController].
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  /// Get instance of [CartController].
  CartController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Modular.to.path)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: controller.onIncrement,
              onLongPress: controller.onDecrement,
              child: Text(controller.count),
            ),
            ElevatedButton(
              onPressed: Modular.to.pop,
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
