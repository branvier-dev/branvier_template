import '../user/user.dart';
import 'auth_repository.dart';

/// A Global Service of AppModule.
class AuthService {
  AuthService(this._repository);
  final AuthRepository _repository;

  /// Whether a user is authenticated.
  bool get isAuthenticated => _repository.isAuthenticated();

  User? getUserFromCache() {
    return _repository.getUserFromCache();
  }
}
