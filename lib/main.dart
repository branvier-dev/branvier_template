import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provide_it/provide_it.dart';

import 'app/app.dart';
import 'app/app_setup.dart';
import 'app/features/auth/repositories/auth_repository.dart';
import 'app/features/auth/repositories/auth_repository_fake.dart';
import 'app/features/auth/repositories/auth_repository_impl.dart';
import 'app/features/auth/view_models/auth_store.dart';
import 'app/features/user/repositories/user_repository.dart';
import 'app/features/user/repositories/user_repository_fake.dart';
import 'app/features/user/repositories/user_repository_impl.dart';
import 'app/services/api/dio_service.dart';
import 'app/services/cache/cache_service.dart';
import 'app/services/cache/cache_service_fake.dart';
import 'app/services/cache/cache_service_impl.dart';
import 'env.dart';

void main() => run(Env.production);

/// Inicializa o app com o ambiente [env].
///
/// Use [builder] p/ testar uma única tela com acesso as dependências, tema e idioma.
Future<void> run(Env env, [WidgetBuilder? builder]) async {
  usePathUrlStrategy();

  // Inicializamos o ambiente.
  Env.init(env);

  runApp(
    ProvideIt(
      provide: (context) => switch (env) {
        Env.development => context.provideFakes(),
        _ => context.provideImpls(),
      },
      child: App(builder: builder),
    ),
  );
}

extension on BuildContext {
  void provideFakes() {
    provide(AppSetup.init);
    provide<AuthRepository>(AuthRepositoryFake.new);
    provide<UserRepository>(UserRepositoryFake.new);
    provideStores();
  }

  void provideImpls() {
    provide(AppSetup.init);
    provide(DioService.new);
    provide<CacheService>(
      kDebugMode ? CacheServiceFake.new : CacheServiceImpl.init,
    );
    provide<AuthRepository>(AuthRepositoryImpl.new);
    provide<UserRepository>(UserRepositoryImpl.new);
    provideStores();
  }

  void provideStores() {
    provide(AuthStore.new);
  }
}
