import 'package:mocktail/mocktail.dart';

abstract class IApi {
  ///Headers to attach to the request. Usually String or List<String>.
  Map<String, dynamic> get headers;

  ///Changes the baseUrl.
  set baseUrl(String url);

  ///CREATE.
  Future<T> post<T>(String path, [data]);

  ///READ.
  Future<T> get<T>(String path);

  ///UPDATE.
  Future<T> put<T>(String path, [data]);

  ///DELETE.
  Future<T> delete<T>(String path);
}

extension IApiExtension on IApi {
  ///The current [token].
  String? get token => headers['authorization'] as String?;

  ///Sets the current [token]. If null, removes.
  set token(String? token) => token == null
      ? headers.remove('authorization')
      : headers['authorization'] = token;
}

///Simple http client Mocker using mocktail.
class MockApi extends Mock implements IApi {
  @override
  var baseUrl = '';

  @override
  final headers = <String, dynamic>{};
}
