import 'dart:async';

import 'package:branvier_template/app/app_routes.dart';
import 'package:branvier_template/app/modules/auth/models/login_data.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/models/user.dart';
import '../../services/my_auth_service.dart';

class LoginController {
  MyAuthService get _myAuth => Modular.get();

  /// Login and navigate to /home/.
  Future<void> onLoginTap() async {
    await _myAuth.login(LoginData(email: 'a@test', password: 'password'));

    final user = User(id: '1', email: 'a@test');
    Modular.to.navigate(AppRoutes.home, arguments: user);
  }
}
