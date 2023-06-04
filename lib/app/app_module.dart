import 'package:flutter_modular/flutter_modular.dart';

import 'app_routes.dart';
import 'shared/sources/dio_api.dart';
import 'shared/sources/hive_box.dart';
import 'shared/sources/interfaces/api_interface.dart';
import 'shared/sources/interfaces/box_interface.dart';
import 'modules/auth/auth_module.dart';
import 'shared/repositories/auth_repository.dart';
import 'shared/services/auth_service.dart';
import 'shared/models/user.dart';
import 'modules/user/user_module.dart';

///Binds the global sources, repositories and services to the app.
class AppModule extends Module {
  @override
  final List<Bind> binds = [
    // * Sources
    AutoBind.lazySingleton<IApi>(DioApi.new),
    AutoBind.lazySingleton<IBox>(HiveBox.new),

    // * Repositories
    AutoBind.lazySingleton(AuthRepository.new),

    // * Services
    AutoBind.lazySingleton(AuthService.new),
  ];

  @override
  final List<ModularRoute> routes = [
    //Logged.
    ModuleRoute('/', module: UserModule(), guards: [AuthGuard(), UserGuard()]),

    //Public.
    ModuleRoute('/auth', module: AuthModule()),
  ];
}

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: AppRoutes.login);

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    return Modular.get<AuthService>().isAuthenticated;
  }
}

class UserGuard extends RouteGuard {
  UserGuard() : super(redirectTo: AppRoutes.login);

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    if (Modular.args.data is User) return true;

    Modular.setArguments(Modular.get<AuthService>().getUserFromCache());
    return Modular.args.data is User;
  }
}
