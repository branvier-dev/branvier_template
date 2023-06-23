import 'package:flutter/material.dart' hide DrawerController;
import 'package:flutter_modular/flutter_modular.dart';

import '../cart/data/cart_repository.dart';
import '../cart/data/cart_service.dart';
import 'home/home_controller.dart';
import 'home/home_page.dart';
import 'user_repository.dart';
import 'user_service.dart';
import 'widgets/cart_button/cart_button_controller.dart';
import 'widgets/drawer/drawer_controller.dart';
import 'widgets/end_drawer/cart_drawer_controller.dart';
import 'widgets/user_outlet.dart';

class UserModule extends Module {
  @override
  final List<Bind> binds = [
    // * Repositories
    AutoBind.singleton(UserRepository.new),
    AutoBind.singleton(CartRepository.new),

    // * Services
    AutoBind.singleton(UserService.new),
    AutoBind.singleton(CartService.new),

    // * Controllers
    AutoBind.singleton(HomeController.new),
    AutoBind.lazySingleton(CartButtonController.new),
    AutoBind.lazySingleton(CartDrawerController.new),
    AutoBind.lazySingleton(DrawerController.new),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const UserOutlet(),
      children: [
        ChildRoute(
          '/home/',
          child: (context, args) => const HomePage(),
          children: [
            ChildRoute(
              '/dialog',
              child: (_, args) => Scaffold(
                appBar: AppBar(
                  title: const Text('Dialog'),
                ),
                body: Center(
                  child: ElevatedButton(
                    onPressed: () => Modular.to.pushNamed('/home/dialog2'),
                    child: const Text('Close'),
                  ),
                ),
              ),
            ),
            ChildRoute(
              '/dialog2',
              child: (_, args) => Scaffold(
                appBar: AppBar(
                  title: const Text('Dialog2'),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ];
}

// class Modules extends ModuleRoute {}
