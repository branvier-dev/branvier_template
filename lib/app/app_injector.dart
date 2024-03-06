// ignore_for_file: inference_failure_on_function_invocation, avoid_late_keyword, avoid_global_state, lines_longer_than_80_chars

import 'package:auto_injector/auto_injector.dart';

import 'core/repositories/theme_repository.dart';
import 'features/auth/repositories/auth_repository.dart';
import 'features/user/repositories/user_repository.dart';
import 'services/api/dio_service.dart';
import 'services/crypto/crypto_service.dart';
import 'services/crypto/flutter_secure_storage_impl.dart';
import 'services/storage/hive_impl.dart';
import 'services/storage/storage_service.dart';

mixin AppInjector {
  static late AutoInjector i;

  static Future<void> setup() async {
    i = AutoInjector();

    // services
    i.addLazySingleton(DioService.new);

    // Abstracted Services
    i.addInstance<StorageService>(await HiveImpl.init());
    i.addLazySingleton<CryptoService>(FlutterSecureStorageImpl.new);

    // Repositories
    i.addLazySingleton(AuthRepository.new);
    i.addLazySingleton(UserRepository.new);
    i.addLazySingleton(ThemeRepository.new);

    i.commit();
  }
}
