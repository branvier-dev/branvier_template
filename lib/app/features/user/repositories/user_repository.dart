import '../../../services/api/dio_service.dart';
import '../../../services/cache/cache_service.dart';
import '../models/user.dart';

class UserRepository {
  const UserRepository(this.api, this.cache);

  final DioService api;
  final CacheService cache;

  /// Get the cached user from the storage.
  User get cachedUser {
    if (cache.get('user') case String json) return User.fromJson(json);

    throw ArgumentError.notNull('cachedUser');
  }
}
