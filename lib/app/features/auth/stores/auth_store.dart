import 'package:flutter/material.dart';

import '../../user/repositories/user_repository.dart';
import '../models/login_dto.dart';
import '../models/register_dto.dart';
import '../repositories/auth_repository.dart';

class AuthStore extends ChangeNotifier {
  AuthStore(this._repository, this._userRepository);
  final AuthRepository _repository;
  final UserRepository _userRepository;

  /// Verifica se o usuário está logado.
  bool get isLogged => _repository.isLogged;

  /// Checa se o usuário está logado e seta o estado global do usuário.
  Future<bool> check() async {
    final user = await _repository.check();
    _userRepository.user = user;

    return isLogged;
  }

  Future<void> login(LoginDto dto) async {
    final user = await _repository.login(dto);
    _userRepository.user = user;
  }

  Future<void> register(RegisterDto dto) async {
    final user = await _repository.register(dto);
    _userRepository.user = user;
  }

  Future<void> logout() async {
    await _repository.logout();
    _userRepository.user = null;
  }
}
