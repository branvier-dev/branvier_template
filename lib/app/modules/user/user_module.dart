import 'package:flutter_modular/flutter_modular.dart';

import '../home/home_module.dart';
import '../../shared/repositories/user_repository.dart';
import 'data/services/user_service.dart';
import 'view/appbar/appbar_controller.dart';
import 'view/drawer/drawer_controller.dart';
import 'view/user_outlet.dart';

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
