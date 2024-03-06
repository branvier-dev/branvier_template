import 'package:flutter/material.dart';

import '../models/login_dto.dart';
import '../models/register_user_dto.dart';
import '../repositories/auth_repository.dart';

class AuthStore extends ChangeNotifier {
  AuthStore(this._repository);

  final AuthRepository _repository;

  String? _token;

  bool get isLogged => _token != null;

  Future<bool> authenticate() async {
    // _token = await _repository.authenticate();
    // notifyListeners();

    // return true;
    return isLogged;
  }

  Future<void> login(LoginDto dto) async {
    _token = await _repository.login(dto);
    notifyListeners();
  }

  Future<void> registerUser(RegisterUserDto dto) async {
    await _repository.registerUser(dto);
    notifyListeners();
  }

  void logout() {
    _repository.logout();
    _token = null;
    notifyListeners();
  }
}
