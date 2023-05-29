import 'package:flutter_modular/flutter_modular.dart';
import 'login/login_page.dart';
import 'register/register_page.dart';
import 'services/project_auth_service.dart';
import 'services/repositories/project_auth_repository.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    AutoBind.lazySingleton(ProjectAuthRepository.new),
    AutoBind.lazySingleton(ProjectAuthService.new),
    // AutoBind.lazySingleton(GoogleAuthService.new),
    // AutoBind.lazySingleton(FacebookAuthService.new),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/login/', child: (_, args) => const LoginPage()),
    ChildRoute('/register/', child: (_, args) => const RegisterPage()),
  ];
}
