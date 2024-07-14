import 'package:flutter/material.dart';

import '../models/login_dto.dart';
import '../models/register_user_dto.dart';
import '../repositories/auth_repository.dart';

class AuthStore extends ChangeNotifier {
  AuthStore(this._repository);

  final AuthRepository _repository;

  bool get isLogged => _repository.isLogged;

  Future<void> login(LoginDto dto) async {
    await _repository.login(dto);
  }

  Future<void> registerUser(RegisterUserDto dto) async {
    await _repository.register(dto);
  }

  void logout() {
    _repository.logout();
  }
}
