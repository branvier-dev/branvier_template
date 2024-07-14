import 'package:dio/dio.dart';

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
    const path = '/auth/login';
    final data = dto.toMap();
    final mock = {
      'token': '123',
      'user': {
        'id': '1',
        'name': 'tester',
        ...data,
      },
    };

    final response = await dio.post<Map>(
      path,
      data: data,
      options: Options(extra: dio.extra(mock: mock)),
    );

    await _authenticate(response);
  }

  Future<void> register(RegisterUserDto dto) async {
    const path = '/auth/register';

    final response = await dio.post<Map>(path, data: dto.toMap());
    await _authenticate(response);
  }

  Future<void> logout() async {
    dio.token = null;
    await storage.clear();
  }

  Future<String> _authenticate(Response<Map> response) async {
    final token = response.data?['token'] as String;
    final map = response.data?['user'] as Map;

    final user = User.fromMap(map.cast());

    await storage.set('user', user.toJson());
    await storage.set('token', token);

    return dio.token = token;
  }
}
