import 'package:flutter_modular/flutter_modular.dart';

import 'repositories/my_auth_repository.dart';
import 'services/my_auth_service.dart';
import 'views/login/login_controller.dart';
import 'views/login/login_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    // * Repositories
    AutoBind.lazySingleton(MyAuthRepository.new),

    // * Services
    AutoBind.lazySingleton(MyAuthService.new),

    // * Controllers
    AutoBind.lazySingleton(LoginController.new),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/login/', child: (_, args) => const LoginPage()),
  ];
}
