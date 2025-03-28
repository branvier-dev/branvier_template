import '../models/login_dto.dart';
import '../models/register_dto.dart';
import 'auth_repository.dart';

class AuthRepositoryFake implements AuthRepository {
  var _logged = true;

  @override
  bool get isLogged => _logged;

  @override
  Future<bool> check() async => _logged;

  @override
  Future<void> login(LoginDto dto) async {
    _logged = true;
  }

  @override
  Future<void> register(RegisterDto dto) async {
    _logged = true;
  }

  @override
  Future<void> logout() async {
    _logged = false;
  }
}
