import 'package:dio/dio.dart';

import '../../../env.dart';
import 'interfaces/api_interface.dart';

class DioApi implements IApi {
  /// Http client.
  final api = Dio(BaseOptions(baseUrl: Env.apiUrl));

  @override
  set baseUrl(String url) => api.options.baseUrl = url;

  @override
  Map<String, dynamic> get headers => api.options.headers;

  @override
  Future<T> get<T>(path) {
    return api.get(path).then(_response, onError: _error<T>);
  }

  @override
  Future<T> post<T>(path, [data]) {
    return api.post(path, data: data).then(_response, onError: _error<T>);
  }

  @override
  Future<T> put<T>(String path, [data]) {
    return api.put(path).then(_response, onError: _error<T>);
  }

  @override
  Future<T> delete<T>(String path) {
    return api.delete(path).then(_response, onError: _error<T>);
  }

  ///Forwards data from [Response].
  Future<T> _response<T>(Response re) async {
    if (re.data == null) throw ApiException('API.RESPONSE_NULL');
    return re.data as T;
  }

  ///Handles errors into exceptions key codes.
  Future<T> _error<T>(Object? e) async {
    if (e is DioError && e.type == DioErrorType.badResponse) {
      return _response(e.response!);
    }
    throw ApiException('API.RESPONSE_ERROR');
  }
}

class ApiException implements Exception {
  ApiException(this.code);
  final String code;

  @override
  String toString() => 'ApiException: $code';
}
