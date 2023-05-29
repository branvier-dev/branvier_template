import 'package:branvier/branvier.dart';

import '../../../user/user.dart';
import '../../auth_repository.dart';

/// Service of AuthModule
class ProjectAuthRepository {
  ProjectAuthRepository(this._api, this._box);
  static const key = AuthRepository.key;

  //Dependencies
  final IApi _api;
  final IBox _box;

  /// Login and set [User].
  Future<User> login(Json map) async {
    final fake = {'email': 'eve.holt@reqres.in', 'password': 'cityslicka'};
    final json = await _api.post<Map>('login', fake);

    return _setUser({...json, ...map, 'id': '1'});
  }

  /// Register and set [User].
  Future<User> register(Json map) async {
    final fake = {'email': 'eve.holt@reqres.in', 'password': 'pistol'};
    final json = await _api.post<Map>('register', fake);

    return _setUser({...json, ...map, 'id': '1'});
  }

  /// Handle error, cache and serialization.
  Future<User> _setUser(Json map) async {
    _api.token = map['token'];

    //Error
    if (map.containsKey('error')) throw KeyException(map['error']);

    //Cache
    await _box.write(key.token, _api.token);
    await _box.write(key.user, map);

    //Serialize
    return User.fromMap(map);
  }
}
