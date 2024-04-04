import '../../../services/api/dio_service.dart';
import '../../../services/storage/storage_service.dart';
import '../models/user.dart';

class UserRepository {
  const UserRepository(this.api, this.storage);

  final DioService api;
  final StorageService storage;

  /// Get the cached user from the storage.
  User get cachedUser {
    if (storage.get('user') case String json) return User.fromJson(json);

    throw ArgumentError.notNull('cachedUser');
  }
}
