import '../../../services/api/dio_service.dart';
import '../../../services/storage/storage_service.dart';
import '../../user/models/user.dart';
import '../models/login_dto.dart';
import '../models/register_user_dto.dart';

class AuthRepository {
  const AuthRepository(this.storage, this.dio);

  final StorageService storage;
  final DioService dio;

  bool get isLogged => storage.get('token') != null;

  Future<void> login(LoginDto dto) async {
    // const path = '/auth/login';

    // final response = await dio.post<Map>(path, data: dto.toMap());
    await authenticateMock(dto.toMap());
  }

  Future<void> registerUser(RegisterUserDto dto) async {
    // const path = '/auth/registerUser';

    // final response = await dio.post<Map>(path, data: dto.toMap());
    await authenticateMock(dto.toMap());
  }

  Future<void> logout() async {
    dio.token = null;
    await storage.clear();
  }

  /// Mocked authentication
  Future<String> authenticateMock(Map<String, dynamic> response) async {
    final map = {
      ...response,
      if (response['name'] == null) //
        'name': 'Juan Almeida',
    };

    final user = User.fromMap(map.cast());

    await storage.set('token', '123');
    await storage.set('user', user.toJson());

    final token = storage.get('token');

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
