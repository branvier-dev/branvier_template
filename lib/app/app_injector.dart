// ignore_for_file: boolean_prefixes, avoid_mutable_global_variables
import 'package:auto_injector/auto_injector.dart';
import 'package:provider/provider.dart';

import 'features/auth/repositories/auth_repository.dart';
import 'features/user/repositories/user_repository.dart';
import 'services/api/dio_service.dart';
import 'services/cache/cache_service.dart';
import 'services/cache/hive_cache_service.dart';
import 'shared/widgets/app_splash.dart';

/// Whether the app is running in test mode.
bool get kIsTest => _test;
bool _test = false;

mixin AppInjector {
  static AutoInjector? _instance;

  /// The instance of [AppInjector]. Only [Injector.get] is accessible.
  static Locator get instance {
    if (_instance case var instance?) return instance;
    throw Exception('You must call AppInjector.setup() before using it.');
  }

  /// Injects all dependencies and returns the service [Locator].
  static Future<Locator> setup({bool test = false}) async {
    final i = AutoInjector();

    // Services
    i.addLazySingleton(DioService.new);

    // Abstracted Services
    i.addInstance<CacheService>(
      kIsTest ? FakeCacheService() : await HiveCacheService.init(),
    );

    // Repositories
    i.addLazySingleton(AuthRepository.new);
    i.addLazySingleton(UserRepository.new);

    await AppSplash.future;

    return _instance = i..commit();
  }
}
