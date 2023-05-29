import 'package:branvier/branvier.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_routes.dart';
import 'core/theme/theme_repository.dart';
import 'core/theme/theme_service.dart';
import 'core/translation/translation_repository.dart';
import 'core/translation/translation_service.dart';
import 'data/source/dio_api.dart';
import 'data/source/hive_box.dart';
import 'modules/auth/auth_module.dart';
import 'modules/auth/auth_repository.dart';
import 'modules/auth/auth_service.dart';
import 'modules/user/user.dart';
import 'modules/user/user_module.dart';

///Binds the global sources, repositories and services to the app.
class AppModule extends Module {
  @override
  final List<Bind> binds = [
    // * Sources
    AutoBind.lazySingleton<IApi>(DioApi.new),
    AutoBind.lazySingleton<IBox>(HiveBox.new),

    // * Repositories
    AutoBind.lazySingleton(TranslationRepository.new),
    AutoBind.lazySingleton(ThemeRepository.new),
    AutoBind.lazySingleton((i) => AuthRepository.new),

    // * Services
    AutoBind.lazySingleton(TranslationService.new),
    AutoBind.lazySingleton(ThemeService.new),
    AutoBind.lazySingleton(AuthService.new),
  ];

  @override
  final List<ModularRoute> routes = [
    //Only logged.
    ModuleRoute('/', module: UserModule(), guards: [AuthGuard(), UserGuard()]),

    //Public.
    ModuleRoute('/auth', module: AuthModule()),
  ];
}

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: Routes.login);

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    return Modular.get<AuthService>().isAuthenticated;
  }
}

class UserGuard extends RouteGuard {
  UserGuard() : super(redirectTo: Routes.login);

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    if (Modular.args.data is User) return true;

    Modular.setArguments(Modular.get<AuthService>().getUserFromCache());
    return Modular.args.data is User;
  }
}
