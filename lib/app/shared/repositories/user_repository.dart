import '../sources/interfaces/api_interface.dart';
import '../sources/interfaces/box_interface.dart';

class UserRepository {
  UserRepository(this._api, this._box);
  static const key = (user: 'user');

  //Dependencies
  final IApi _api;
  final IBox _box;

  /// Logout and clear all cache.
  Future<void> logout() async {
    _api.token = null;
    await _box.deleteAll();
  }
}
