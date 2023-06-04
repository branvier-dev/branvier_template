import 'package:flutter_modular/flutter_modular.dart';

import '../home/home_module.dart';
import '../../shared/repositories/user_repository.dart';
import 'services/user_service.dart';
import 'views/appbar/appbar_controller.dart';
import 'views/drawer/drawer_controller.dart';
import 'views/user_outlet.dart';

class UserModule extends Module {
  @override
  final List<Bind> binds = [
    // * Repositories
    AutoBind.singleton(UserRepository.new),

    // * Services
    AutoBind.singleton(UserService.new),

    // * Controllers
    AutoBind.lazySingleton(DrawerController.new),
    AutoBind.lazySingleton(AppBarController.new),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const UserOutlet(),
      children: [
        ModuleRoute('/home', module: HomeModule()),
      ],
    ),
  ];
}
