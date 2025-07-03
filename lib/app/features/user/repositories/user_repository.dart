import '../../../services/api/dio_service.dart';
import '../../../services/cache/cache_service.dart';
import '../models/user.dart';

class UserRepository {
  UserRepository(this._api, this._cache);
  final DioService _api;
  final CacheService _cache;

  Future<User> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  Future<void> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
