import 'package:branvier_template/app/modules/auth/models/login_data.dart';

import '../repositories/my_auth_repository.dart';

class MyAuthService {
  MyAuthService(this._repository);
  final MyAuthRepository _repository;

  Future<void> login(LoginData data) async {
    await _repository.login(data);
  }
}
