import '../sources/interfaces/api_interface.dart';
import '../sources/interfaces/box_interface.dart';
import '../models/user.dart';

class AuthRepository {
  AuthRepository(this._api, this._box);
  static const key = (token: 'token', user: 'user');

  //Dependencies
  final IApi _api;
  final IBox _box;

  /// Checks if the user is already authenticated.
  bool isAuthenticated() {
    _api.token = _box.read(key.token);

    if (_api.token == null) _box.deleteAll();
    return _api.token != null;
  }

  /// Get [User] from cache or null.
  User? getUserFromCache() {
    final map = _box.read<Map>(key.user)?.cast<String, dynamic>();
    return map != null ? User.fromMap(map) : null;
  }
}
