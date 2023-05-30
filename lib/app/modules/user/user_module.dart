import 'package:flutter_modular/flutter_modular.dart';

import '../cart/data/cart_repository.dart';
import '../cart/data/cart_service.dart';
import 'home/home_page.dart';
import 'user_repository.dart';
import 'user_service.dart';
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
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const UserOutlet(),
      children: [
        ChildRoute('/home/', child: (_, args) => const HomePage()),
      ],
    ),
  ];
}

// class Modules extends ModuleRoute {}
