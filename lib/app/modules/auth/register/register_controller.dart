import 'dart:async';

import 'package:branvier/branvier.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../services/project_auth_service.dart';

///Controls RegisterPage.
class RegisterController extends Disposable {
  //Dependencies
  ProjectAuthService get _myProject => Modular.get();

  //States
  final formx = FormController();

  FutureOr<void> onRegister() async {
    await _myProject.register(formx.submit());
    Modular.to.navigate('/home/');
  }

  @override
  void dispose() {
    // _service
  }
}
