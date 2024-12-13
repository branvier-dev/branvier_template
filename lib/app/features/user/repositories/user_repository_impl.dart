import '../../../services/api/dio_service.dart';
import '../../../services/cache/cache_service.dart';
import '../models/user_model.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this.api, this.cache);
  final DioService api;
  final CacheService cache;

  @override
  Future<UserModel> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
