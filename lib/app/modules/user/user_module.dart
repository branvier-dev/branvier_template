import 'package:flutter_modular/flutter_modular.dart';

import 'home/home_page.dart';
import 'user_repository.dart';
import 'user_service.dart';
import 'widgets/user_outlet.dart';

class UserModule extends Module {
  @override
  final List<Bind> binds = [
    AutoBind.singleton(UserRepository.new),
    AutoBind.singleton(UserService.new),
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
