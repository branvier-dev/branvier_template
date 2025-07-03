import 'package:dio/dio.dart';

class ApiException extends DioException {
  ApiException.from(DioException e)
    : super(
        requestOptions: e.requestOptions,
        response: e.response,
        type: e.type,
        error: e.error,
        stackTrace: e.stackTrace,
        message: e.message,
      );

  @override
  /// Tenta extrair uma mensagem de erro amigável.
  String get message => switch (response?.data) {
    {'message': String message} => message,
    {'message': List list} when list.isNotEmpty => '${list.first}',
    _ => super.message ?? type.name,
  };
}
