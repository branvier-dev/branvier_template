import 'package:branvier/branvier.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/repositories/auth_repository.dart';
import 'data/repositories/theme_repository.dart';
import 'data/repositories/translation_repository.dart';
import 'data/source/hive_box.dart';
import 'data/source/secure_box.dart';
import 'modules/auth/auth_module.dart';
import 'modules/main/main_module.dart';
import 'services/app/auth_service.dart';
import 'services/app/theme_service.dart';
import 'services/app/translation_service.dart';

///Binds the global sources, repositories and services to the app.
class AppModule extends Module {
  @override
  final List<Bind> binds = [
    //Sources
    // Bind<IApi>((i) => DioApi()),
    Bind<IApi>((i) => MockApi()), // ! mocked
    Bind<ISafeBox>((i) => SecureBox()),
    AsyncBind<IOpenBox>((i) => HiveBox().init()),

    //Repositories
    Bind((i) => TranslationRepository(i())),
    Bind((i) => ThemeRepository(i())),
    Bind((i) => AuthRepository(i(), i())),

    //Services
    Bind((i) => TranslationService(i())),
    AsyncBind((i) => ThemeService(i()).init()),
    AsyncBind((i) => AuthService(i()).init()),
  ];

  @override
  final List<ModularRoute> routes = [
    //Only logged.
    ModuleRoute('/', module: MainModule(), guards: [AuthGuard()]),

    //Public.
    ModuleRoute('/auth', module: AuthModule()),
  ];
}

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/auth/');

  @override
  bool canActivate(String path, ModularRoute route) {
    return Modular.get<AuthService>().isLogged;
  }
}
