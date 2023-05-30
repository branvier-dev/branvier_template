import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:getx_lite/getx_lite.dart';

import 'cart_button_controller.dart';

class CartButtonWidget extends WidgetModule {
  const CartButtonWidget({super.key});

  @override
  List<Bind> get binds => [AutoBind.lazySingleton(CartButtonController.new)];

  /// Get instance of [CartButtonController].
  CartButtonController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: controller.onCartButton,
    );
  }
}
