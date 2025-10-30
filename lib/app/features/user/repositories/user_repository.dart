import '../../../services/api/dio_service.dart';
import '../../../services/cache/cache_service.dart';
import '../models/user.dart';

class UserRepository {
  UserRepository(this._api, this._cache);
  final DioService _api;
  final CacheService _cache;

  Future<User> getUser() async {
    await Future.delayed(const Duration(seconds: 1));
    return const User(
      id: '-1',
      name: 'John Doe',
      email: 'john.doe@example.com',
    );
  }

  Future<void> updateUser(User user) async {}
}
