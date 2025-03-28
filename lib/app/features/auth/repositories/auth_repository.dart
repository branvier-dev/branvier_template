import 'package:provide_it/provide_it.dart';

import '../models/login_dto.dart';
import '../models/register_dto.dart';

abstract class AuthRepository {
  /// O método [isLogged] verifica se o usuário está logado.
  bool get isLogged;

  /// O método [check] carrega se o usuário está logado.
  Future<bool> check();

  /// O método [login] realiza o login do usuário.
  Future<void> login(LoginDto dto);

  /// O método [register] realiza o cadastro do usuário.
  Future<void> register(RegisterDto dto);

  // Ao realizar o logout, o token e o usuário são removidos do cache.
  Future<void> logout();
}

final tokenRef = ProvideRef((String patientId) => 'token');
