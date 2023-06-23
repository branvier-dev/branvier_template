import 'package:branvier/branvier.dart';
import 'package:dartx/dartx.dart';

import 'user.dart';

/// [UserRepository] encapsulates all data processing of [User].
class UserRepository {
  UserRepository(this._api, this._box);
  static const key = 'user';

  //Dependencies
  final IApi _api;
  final IBox _box;

  /// Logout and clear all cache.
  Future<void> logout() async {
    _api.token = null;
    await _box.deleteAll();
  }

  Future<User> getUser() async {
    await 1.seconds.delay;
    return User(id: '1', email: 'email@com');
  }
}
