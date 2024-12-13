import 'package:auto_injector/auto_injector.dart';

import 'app/features/auth/repositories/auth_repository.dart';
import 'app/features/auth/repositories/auth_repository_fake.dart';
import 'app/features/user/repositories/user_repository.dart';
import 'app/features/user/repositories/user_repository_fake.dart';
import 'env.dart';
import 'main.dart' as app;

void main() => app.main([Env.development.name]);

extension LocalInjector on Injector {
  Future<void> addFakes() async {
    // Repositories
    addLazySingleton<AuthRepository>(AuthRepositoryFake.new);
    addLazySingleton<UserRepository>(UserRepositoryFake.new);
  }
}
