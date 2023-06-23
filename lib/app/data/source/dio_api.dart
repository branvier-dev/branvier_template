import 'dart:convert';

import 'package:branvier/branvier.dart';
import 'package:dio/dio.dart';

import '../../../env.dart';

class DioApi implements IApi {
  DioApi();

  ///Http client.
  final api = Dio(BaseOptions(baseUrl: Env.apiUrl));

  @override
  set baseUrl(String url) => api.options.baseUrl = url;

  @override
  Json get headers => api.options.headers;

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
    if (re.data == null) throw ApiException('API.RESPONSE_ERROR');
    return jsonEncode(re.data).parse<T>();
  }

  ///Handles errors into exceptions key codes.
  Future<T> _error<T>(Object? e) async {
    if (e is DioException) {
      if (e.type == DioExceptionType.badResponse) return _response(e.response!);
      throw ApiException('API.${e.type.name.dotCase.toUpperCase()}');
    }
    throw ApiException('API.RESPONSE_ERROR');
  }
}
