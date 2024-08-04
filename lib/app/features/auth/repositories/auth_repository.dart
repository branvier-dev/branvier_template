import 'package:dio/dio.dart';

import '../../../services/api/dio_service.dart';
import '../../../services/cache/cache_service.dart';
import '../../user/models/user.dart';
import '../models/login_dto.dart';
import '../models/register_dto.dart';

class AuthRepository {
  const AuthRepository(this.cache, this.dio);

  final CacheService cache;
  final DioService dio;

  bool get isLogged => cache.get('token') != null;

  Future<void> login(LoginDto dto) async {
    const path = '/auth/login';
    final data = dto.toMap();
    final mock = _mock(data);

    // Use `dio.extra` para marcar a requisição como mock.
    // Assim o response.data será simulado e não será feita uma requisição real.
    final response = await dio.post<Map>(
      path,
      data: data,
      options: Options(extra: dio.extra(mock: mock)),
    );
    await _authenticate(response);
  }

  Future<void> register(RegisterDto dto) async {
    const path = '/auth/register';
    final data = dto.toMap();
    final mock = _mock(data);

    final response = await dio.post<Map>(
      path,
      data: data,
      options: Options(extra: dio.extra(mock: mock)),
    );
    await _authenticate(response);
  }

  // Ao realizar o logout, o token e o usuário são removidos do cache.
  Future<void> logout() async {
    dio.token = null;
    await cache.clear();
  }

  /// Ao realizar o login ou registro, o token e o usuário são
  /// armazenados no cache.
  ///
  /// Assim, o token é automaticamente enviado nas próximas requisições, e
  /// o backend poderá identificar se o usuário está logado.
  ///
  /// O token é armazenado no cache para que o usuário não precise fazer login
  /// toda vez que abrir o app.
  ///
  Future<String> _authenticate(Response<Map> response) async {
    final token = response.data?['token'] as String;
    final map = response.data?['user'] as Map;

    final user = User.fromMap(map.cast());

    await cache.set('user', user.toJson());
    await cache.set('token', token);

    return dio.token = token;
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
