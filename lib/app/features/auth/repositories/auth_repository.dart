import '../../../services/api/dio_service.dart';
import '../../../services/crypto/crypto_service.dart';
import '../../../services/storage/storage_service.dart';
import '../../user/models/user.dart';
import '../models/login_dto.dart';
import '../models/register_user_dto.dart';

class AuthRepository {
  const AuthRepository(this.crypto, this.storage, this.dio);

  final CryptoService crypto;
  final StorageService storage;
  final DioService dio;

  Future<String> login(LoginDto dto) async {
    // const path = '/auth/login';

    // final response = await dio.post<Map>(path, data: dto.toMap());
    return authenticateMock(dto.toMap());
  }

  Future<String> registerUser(RegisterUserDto dto) async {
    // const path = '/auth/registerUser';

    // final response = await dio.post<Map>(path, data: dto.toMap());
    return authenticateMock(dto.toMap());
  }

  void logout() {
    crypto.delete('token').ignore();
    dio.token = null;
  }

  /// Mocked authentication
  Future<String> authenticateMock(Map<String, dynamic> response) async {
    final map = {
      ...response,
      if (response['name'] == null) //
        'name': 'Juan Almeida',
    };

    final user = User.fromMap(map.cast());

    await crypto.set('token', '123');
    await storage.set('user', user.toJson());

    final token = await crypto.get('token');

    if (token != null) {
      dio.token = token;

      return token;
    } else {
      dio.token = '123';
    }

    // throw ArgumentError.notNull('token');
    return '123';
  }
}
