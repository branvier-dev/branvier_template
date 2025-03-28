import 'package:flutter/material.dart';

import '../models/login_dto.dart';
import '../models/register_dto.dart';
import '../repositories/auth_repository.dart';

class AuthStore extends ChangeNotifier {
  AuthStore(this._repository);
  final AuthRepository _repository;

  /// Verifica se o usuário está logado.
  bool get isLogged => _repository.isLogged;

  /// Checa se o usuário está logado e seta o estado global do usuário.
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
