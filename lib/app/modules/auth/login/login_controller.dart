import 'dart:async';

import 'package:branvier/branvier.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../services/project_auth_service.dart';

///Controls AuthPage.
class LoginController {
  //Services
  ProjectAuthService get _auth => Modular.get();

  //States
  final formx = FormController();

  /// On submit, login and navigate to /home/.
  Future<void> onLoginSubmit(Json form) async {
    final user = await _auth.login(form);
    Modular.to.navigate('/home/', arguments: user);
  }

  /// On tap, submit, login and navigate to /home/.
  Future<void> onLoginTap() async {
    final user = await _auth.login(formx.submit());
    Modular.to.navigate('/home/', arguments: user);
  }

  /// On tap, navigates to /register/.
  Future<void> onRegisterTap() async {
    await Modular.to.pushNamed('/auth/register/');
  }
}
