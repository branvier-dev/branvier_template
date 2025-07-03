import 'package:flutter/material.dart';

import '../models/login_dto.dart';
import '../models/register_dto.dart';
import '../repositories/auth_repository.dart';

class AuthNotifier extends ChangeNotifier {
  AuthNotifier(this._repository);
  final AuthRepository _repository;

  /// Verifica se o usuário está logado.
  bool get isLogged => _repository.isLogged;

  /// Checa se o usuário está logado.
  Future<bool> check() async {
    await _repository.check();

    return isLogged;
  }

  Future<void> login(LoginDto dto) async {
    await _repository.login(dto);
  }

  Future<void> register(RegisterDto dto) async {
    await _repository.register(dto);
  }

  Future<void> logout() async {
    await _repository.logout();
  }
}
