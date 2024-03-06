import '../../../services/api/dio_service.dart';
import '../../../services/storage/storage_service.dart';
import '../models/user.dart';

class UserRepository {
  const UserRepository(this.api, this.storage);

  final DioService api;
  final StorageService storage;

  User getUser() {
    final json = storage.get('user');

    if (json case String json) {
      return User.fromJson(json);
    }

    throw Exception('User not found');
  }

  void clearUser() {
    storage.remove('user').ignore();
  }
}
