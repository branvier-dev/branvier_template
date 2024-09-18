import '../../../services/api/dio_service.dart';
import '../../../services/cache/cache_service.dart';
import '../models/user_model.dart';

class UserRepository {
  UserRepository(this.api, this.cache);
  final DioService api;
  final CacheService cache;

  /// O estado global do usuário. Ele é gerenciado pelo `UserStore`.
  UserModel? user;

  Future<void> updateUser(UserModel user) async {
    // await service_to_update_user
    this.user = user;
  }
}
