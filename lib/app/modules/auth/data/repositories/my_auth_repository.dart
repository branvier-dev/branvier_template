import 'package:branvier_template/app/modules/auth/data/models/login_data.dart';
import 'package:branvier_template/app/shared/models/user.dart';

import '../../../../shared/sources/interfaces/api_interface.dart';
import '../../../../shared/sources/interfaces/box_interface.dart';

class MyAuthRepository {
  MyAuthRepository(this._api, this._box);
  static const key = (token: 'token', user: 'user');

  //Dependencies
  final IApi _api;
  final IBox _box;

  Future<void> login(LoginData data) async {
    final re = await _api.post('/login', fakeLogin);
    await _box.write(key.token, _api.token = re['token']);
    await _box.write(key.user, User(id: '1', email: data.email).toMap());
  }
}

const fakeLogin = {"email": "eve.holt@reqres.in", "password": "cityslicka"};
