import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provide_it/provide_it.dart';

import 'app/app.dart';
import 'app/features/auth/repositories/auth_repository.dart';
import 'app/features/auth/repositories/auth_repository_fake.dart';
import 'app/features/auth/view_models/auth_notifier.dart';
import 'app/features/user/repositories/user_repository.dart';
import 'app/features/user/repositories/user_repository_fake.dart';
import 'app/services/api/dio_service.dart';
import 'app/services/cache/cache_service.dart';
import 'app/services/cache/cache_service_impl.dart';
import 'env.dart';

void main() => run(kReleaseMode ? Env.production : Env.development);

/// Inicializa o app com o ambiente [env].
///
/// Use [builder] p/ testar uma única tela com acesso as dependências, tema e idioma.
Future<void> run(Env env, [WidgetBuilder? builder]) async {
  await Env.init(env);

  runApp(
    ProvideIt(
      provide: (context) {
        // Services
        context.provide(DioService.new);
        context.provide<CacheService>(CacheServiceImpl.async);
        // context.provide(FirebaseService.async);

        // Repositories
        context.provide(AuthRepository.new);
        context.provide(UserRepository.new);

        // Stores
        context.provide(AuthNotifier.new);
      },
      override: (context) {
        if (Env.current != Env.development) return;

        context.provide<AuthRepository>(AuthRepositoryFake.new);
        context.provide<UserRepository>(UserRepositoryFake.new);
      },
      child: App(builder: builder),
    ),
  );
}
