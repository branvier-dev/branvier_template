import '../models/login_dto.dart';
import '../models/register_dto.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  // TODO: implement isLogged
  bool get isLogged => throw UnimplementedError();

  @override
  Future<bool> check() {
    // TODO: implement check
    throw UnimplementedError();
  }

  @override
  Future<void> login(LoginDto dto) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> register(RegisterDto dto) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
