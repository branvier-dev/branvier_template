import 'package:branvier/branvier.dart';
import 'package:dio/dio.dart';

class DioApi implements IApi {
  ///Http client.
  final api = Dio(BaseOptions(baseUrl: 'set_api_url')); //todo set baseUrl

  @override
  set baseUrl(String url) => api.options.baseUrl = url;

  @override
  Json get headers => api.options.headers;

  @override
  Future<T> get<T>(path) {
    return api.get(path).then(_response, onError: _error);
  }

  @override
  Future<T> post<T>(path, [data]) {
    return api.post(path, data: data).then(_response, onError: _error);
  }

  @override
  Future<T> put<T>(String path, [data]) {
    return api.put(path).then(_response, onError: _error);
  }

  @override
  Future<T> delete<T>(String path) {
    return api.delete(path).then(_response, onError: _error);
  }

  ///Forwards data from [Response].
  Future<T> _response<T>(Response re) async {
    if (re.data == null) throw ApiException('API.RESPONSE_ERROR');
    return re.data;
  }

  ///Handles errors into exceptions key codes.
  void _error(Object? e) async {
    if (e is DioError) {
      if (e.type == DioErrorType.badResponse) return _response(e.response!);
      throw ApiException(e.type.name.dotCase.toUpperCase());
    }
    throw ApiException('API.RESPONSE_ERROR');
  }
}
