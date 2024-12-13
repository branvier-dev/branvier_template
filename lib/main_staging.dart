import 'package:auto_injector/auto_injector.dart';

import 'app/features/auth/repositories/auth_repository.dart';
import 'app/features/auth/repositories/auth_repository_impl.dart';
import 'app/features/user/repositories/user_repository.dart';
import 'app/features/user/repositories/user_repository_impl.dart';
import 'app/services/api/dio_service.dart';
import 'app/services/cache/cache_service_fake.dart';
import 'app/services/cache/cache_service_impl.dart';
import 'env.dart';
import 'main.dart' as app;

void main() => app.main([Env.staging.name]);

extension RemoteInjector on Injector {
  Future<void> addImpls({required bool test}) async {
    // Services
    addSingleton(DioService.new);
    addInstance(test ? CacheServiceFake() : await CacheServiceImpl.init());

    // Repositories
    addLazySingleton<AuthRepository>(AuthRepositoryImpl.new);
    addLazySingleton<UserRepository>(UserRepositoryImpl.new);
  }
}
