import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'cart_button_controller.dart';

class CartButtonWidget extends StatelessWidget {
  const CartButtonWidget({super.key});


  /// Get instance of [CartButtonController].
  CartButtonController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: controller.onCartButton,
    );
  }
}
