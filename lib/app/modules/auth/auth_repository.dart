import 'package:branvier/branvier.dart';

import '../user/user.dart';

const key = '';
/// [AuthRepository] encapsulates all data processing of Auth.
class AuthRepository {
  AuthRepository(this._api, this._box);
  static const key = (token: 'token', user: 'user');
  final keyy = '';

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
    final json = _box.read<Json>(key.user);
    return json != null ? User.fromMap(json) : null;
  }
}
