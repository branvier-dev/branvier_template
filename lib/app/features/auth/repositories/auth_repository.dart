import '../models/login_dto.dart';
import '../models/register_dto.dart';

class AuthRepository {
  bool get isLogged => true;

  Future<bool> check() async {
    await Future.delayed(const Duration(seconds: 1));
    return isLogged;
  }

  Future<void> login(LoginDto dto) async {}

  Future<void> logout() async {}

  Future<void> register(RegisterDto dto) async {}
}
