// ignore_for_file: prefer_declaring_const_constructors
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_exception.dart';

typedef Json = Map<String, dynamic>;

class DioService extends DioMixin {
  DioService() {
    httpClientAdapter = HttpClientAdapter();
    options = BaseOptions(
      baseUrl: '',
    );
  }

  /// The cache options.
  final cache = CacheOptions(
    // The path is null because Hive was already initialized.
    store: HiveCacheStore(null),
    // Each cache registry expire time.
    maxStale: 7.days,
  );

  /// Gets the authorization token.
  String? get token => options.headers['authorization'] as String?;

  /// Sets the authorization token.
  set token(String? value) => options.headers['authorization'] = value;

  @override
  Interceptors get interceptors => Interceptors()
    ..addAll([
      // Logs requests and responses.
      PrettyDioLogger(
        maxWidth: 50,
        requestBody: true,
        logPrint: (o) {
          dev.log('$o', name: 'dio');
        },
      ),

      // Mock interceptor.
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (options.extra case {'@mock@': Object data}) {
            handler.resolve(
              Response(
                data: data,
                statusCode: 200,
                requestOptions: options..extra.remove('@cache_options@'),
                extra: {'@fromMock@': true},
              ),
              true,
            );
          } else {
            handler.next(options);
          }
        },
      ),

      // Cache interceptor.
      DioCacheInterceptor(options: cache),
      InterceptorsWrapper(
        onResponse: (response, handler) {
          dev.log(
            name: 'dio',
            switch (response.extra) {
              {'@fromMock@': true} => 'Source: mock',
              {'@fromNetwork@': false} => 'Source: cache',
              _ => 'Source: network',
            },
          );
          handler.next(response);
          // jlog(response.data);
        },
      ),

      // ApiException wrapper.
      InterceptorsWrapper(
        onError: (e, handler) => handler.next(_ApiException.from(e)),
      ),
    ]);

  Map<String, dynamic> extra({
    bool forceCache = false,
    Object? mock,
  }) {
    return {
      if (forceCache)
        ...cache.copyWith(policy: CachePolicy.forceCache).toExtra(),
      if (kDebugMode) ...{'@mock@': mock},
    };
  }
}

class _ApiException extends DioException implements ApiException {
  _ApiException.from(DioException e)
      : super(
          requestOptions: e.requestOptions,
          response: e.response,
          type: e.type,
          error: e.error,
          stackTrace: e.stackTrace,
        );

  @override
  String get message {
    if (response?.data case {'error': String message}) return message;

    return switch (type) {
      DioExceptionType.connectionTimeout => 'null',
      DioExceptionType.sendTimeout => 'null',
      DioExceptionType.receiveTimeout => 'null',
      DioExceptionType.badCertificate => 'null',
      DioExceptionType.badResponse => 'null',
      DioExceptionType.cancel => 'null',
      DioExceptionType.connectionError => 'null',
      DioExceptionType.unknown => 'null',
    };
  }
}

@visibleForTesting
Future<String> jlog(Object? object) async {
  final json = const JsonEncoder.withIndent('  ').convert(object);
  await Clipboard.setData(ClipboardData(text: json));

  return json;
}
