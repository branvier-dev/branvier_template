import 'package:branvier/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../cart/data/cart_service.dart';
import 'appbar/appbar_widget.dart';
import 'cart_button/cart_button_widget.dart';
import 'drawer/drawer_widget.dart';
import 'end_drawer/cart_drawer_widget.dart';

///[UserOutlet] exposes all nested children.
class UserOutlet extends StatelessWidget {
  const UserOutlet({super.key});

  CartService get cart => Modular.get();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: cart.drawerKey,
        appBar: const AppBarWidget(),
        drawer: const DrawerWidget(),
        endDrawer: const CartDrawerWidget(),
        floatingActionButton: cart.isNotEmpty ? const CartButtonWidget() : null,
        body: const RouterOutlet(),
      ),
    );
  }
}
