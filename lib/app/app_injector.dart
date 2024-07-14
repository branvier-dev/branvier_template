import 'package:auto_injector/auto_injector.dart';
import 'package:provider/provider.dart';

import 'core/repositories/theme_repository.dart';
import 'features/auth/repositories/auth_repository.dart';
import 'features/user/repositories/user_repository.dart';
import 'services/api/dio_service.dart';
import 'services/storage/hive_impl.dart';
import 'services/storage/storage_service.dart';
import 'shared/widgets/app_splash.dart';

mixin AppInjector {
  static AutoInjector? _instance;
  static bool _isTest = false;

  /// Whether the app is running in test mode.
  static bool get isTest => _isTest;

  /// The instance of [AppInjector]. Only the [Injector.get] is accessible.
  static Locator get instance {
    if (_instance case var instance?) return instance;
    throw Exception('You must call AppInjector.setup() before using it.');
  }

  /// Injects all dependencies and returns the service [Locator].
  static Future<AutoInjector> setup({bool test = false}) async {
    final i = AutoInjector();
    _isTest = test;

    // Services
    i.addLazySingleton(DioService.new);

    // Abstracted Services
    i.addInstance(test ? StorageService() : await HiveImpl.init());

    // Repositories
    i.addLazySingleton(AuthRepository.new);
    i.addLazySingleton(UserRepository.new);
    i.addLazySingleton(ThemeRepository.new);

    await AppSplash.future;

    return _instance = i..commit();
  }
}
