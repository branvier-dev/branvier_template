import 'package:auto_injector/auto_injector.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'features/auth/repositories/auth_repository.dart';
import 'features/user/repositories/user_repository.dart';
import 'services/api/dio_service.dart';
import 'services/cache/cache_service.dart';
import 'services/cache/shared_cache_service.dart';
import 'shared/widgets/app_splash.dart';

/// Whether the app is running in test mode.
bool get kIsTest => _test;
bool _test = false;

extension AppInjector on BuildContext {
  @visibleForTesting
  static var i = AutoInjector();

  // Atalho para chamar os repositórios pelo `context`.
  // Ex: `context<AuthRepository>()` ou simplesmente `i()`.
  T call<T>() => i();

  /// Injects all dependencies and returns the service [Locator].
  static Future<Locator> init({bool test = false}) async {
    i = AutoInjector();
    _test = test;

    // Abstracted Services
    i.addInstance<CacheService>(
      kIsTest ? FakeCacheService() : await SharedCacheService.init(),
    );

    // Services
    i.addLazySingleton(DioService.new);

    // Repositories
    i.addLazySingleton(AuthRepository.new);
    i.addLazySingleton(UserRepository.new);

    await AppSplash.future;

    return i..commit();
  }
}
