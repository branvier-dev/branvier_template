import 'package:asp/asp.dart';
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
    return Scaffold(
      key: cart.drawerKey,
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      endDrawer: const CartDrawerWidget(),
      floatingActionButton: context.select(() {
        return cart.items.isNotEmpty ? const CartButtonWidget() : null;
      }),
      body: RouterOutlet(
        observers: [
          HeroController(
            createRectTween: (begin, end) {
              return MaterialRectCenterArcTween(begin: begin, end: end);
            },
          ),
        ],
      ),
    );
  }
}
