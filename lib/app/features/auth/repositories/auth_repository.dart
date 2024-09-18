import '../../../services/api/dio_service.dart';
import '../../../services/cache/cache_service.dart';
import '../../user/models/user_model.dart';
import '../models/login_dto.dart';
import '../models/register_dto.dart';

class AuthRepository {
  const AuthRepository(this.cache, this.dio);

  final CacheService cache;
  final DioService dio;

  bool get isLogged => (dio.token = cache.get('token')) != null;

  Future<UserModel?> check() async {
    if (!isLogged) return null;

    // final response = await dio.get<Map>('/auth/check');
    return _authenticate(_mock({}));
  }

  Future<UserModel> login(LoginDto dto) async {
    const path = '/auth/login';
    final data = dto.toMap();

    // final response = await dio.post<Map>(path, data: data);
    return _authenticate(_mock(data));
  }

  Future<UserModel> register(RegisterDto dto) async {
    const path = '/auth/register';
    final data = dto.toMap();

    // final response = await dio.post<Map>(path, data: data);

    return _authenticate(_mock(data));
  }

  // Ao realizar o logout, o token e o usuário são removidos do cache.
  Future<void> logout() async {
    dio.token = null;
    await cache.clear();
  }

  /// O token é setado para automaticamente ser enviado nas próximas requisições
  /// , assim o backend poderá identificar se o usuário está logado.
  ///
  /// O token é armazenado no cache para que o usuário não precise fazer login
  /// toda vez que abrir o app.
  ///
  Future<UserModel> _authenticate(Map data) async {
    final token = data['token'] as String;
    final map = data['user'] as Map;

    final user = UserModel.fromMap(map.cast());

    await cache.set('token', token);
    dio.token = token;

    return user;
  }

  /// Simula a resposta do backend.
  ///
  /// Normalmente o backend retornará um mapa estruturado com o token e os
  /// dados do usuário dentro. Note que isso também pode ser feito em duas
  /// endpoints separadas, dependendo do back.
  Map<String, dynamic> _mock(Map<String, dynamic> data) {
    return {
      'token': '123',
      'user': {
        'id': '1',
        'name': 'Fake Name',
        ...data,
      },
    };
  }
}
