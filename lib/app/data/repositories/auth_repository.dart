import 'package:branvier/branvier.dart';
import 'package:mocktail/mocktail.dart';

/// [AuthRepository] encapsulates all data processing of Auth.
class AuthRepository {
  AuthRepository(this._api, this._box);
  static const key = 'auth';

  //Dependencies
  final IApi _api;
  final ISafeBox _box; //secure cache.

  ///Auth check.
  Future<bool> checkAuthentication() async {
    final token = await _box.read<String>('$key.token');
    if (token == null) return false;
    _api.token = token;
    return true;
  }

  ///Login.
  Future<void> login(Json map, bool remember) async {
    //Only if [IApi] is Mock.
    when(() => _api.get(any())).thenAnswer((_) async => _api.token = 'mock');

    //Login via api.
    await _api.get('auth/login?data=$map');

    //Save to safe box.
    await _box.write('$key.token', _api.token);
    final token = await _box.read<String>('$key.token');

    if (remember) await _box.write('$key.pw', map['password']);
  }

  //Password Secure Cache
  Future<String?> getPassword() async => _box.read('$key.pw');

  Future<void> forgotPassword(String email) async {
    when(() => _api.get(any())).thenAnswer((_) async => _api.token = 'mock');

    //Login via api.
    await _api.get('auth/forgot?email=$email');
  }

  Future<void> logout() async {
    _api.token = null;
    await _box.delete('$key.token');
  }
}
