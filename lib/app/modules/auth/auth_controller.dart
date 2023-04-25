import 'dart:async';

import 'package:branvier/branvier.dart';
import 'package:branvier/state.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../services/app/auth_service.dart';

///Controls AuthPage.
class AuthController {
  AuthController() {
    postFrame(init);
  }
  //Services
  AuthService get _auth => Modular.get();

  //States
  final _formx = FormController();
  final _passwordx = FieldController();
  final _emailx = FieldController();
  final _check = false.obs;

  //Getters
  FormController get formx => _formx;
  FieldController get passwordx => _passwordx;
  FieldController get emailx => _emailx;

  void init() {
    _passwordx.text = _auth.password ?? '';
  }

  Future<void> onBoxCheck() async {
    _check.toggle(); //alternates between true & false
  }

  Future<void> onLogin() async {
    if (!_formx.validate()) return;
    await _auth.login(_formx.form!, remember: false);
    Modular.to.navigate('/home/');
  }
}
