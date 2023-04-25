import 'package:branvier/branvier.dart';
import 'package:branvier/state.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../data/repositories/auth_repository.dart';

/// [AuthService] encapsulates all business logic of Auth.
class AuthService {
  AuthService(this._repository);
  final AuthRepository _repository;

  //States
  final _logged = false.obs;
  final _password = ''.obn; //null

  //Getters
  bool get isLogged => _logged.value;
  String? get password => _password.value;

  //Async initializer
  Future<AuthService> init() async {
    _logged.value = await _repository.checkAuthentication();
    _password.value = await _repository.getPassword();
    return this;
  }

  ///Authenticate the user.
  Future<void> login(Json map, {required bool remember}) async {
    await _repository.login(map, remember);
    _logged.value = await _repository.checkAuthentication();
    print(_logged.value);
  }

  ///Authenticate the user.
  Future<void> forgotPassword(String email) async {
    await _repository.forgotPassword(email);
  }

  Future<void> logout() async {
    await _repository.logout();
    _logged.value = await _repository.checkAuthentication();
    Modular.to.navigate('/');
  }
}
