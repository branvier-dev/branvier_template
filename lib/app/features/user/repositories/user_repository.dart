import '../../../services/api/dio_service.dart';
import '../../../services/cache/cache_service.dart';
import '../models/user_model.dart';

class UserRepository {
  UserRepository(this._api, this._cache);
  final DioService _api;
  final CacheService _cache;

  Future<UserModel> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  Future<void> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
