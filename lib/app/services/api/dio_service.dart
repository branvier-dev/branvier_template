// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../env.dart';
import '../../app_injector.dart';

typedef UploadCallback = Future<String> Function(XFile xfile);

class DioService extends DioMixin {
  DioService() {
    httpClientAdapter = HttpClientAdapter();
    options = BaseOptions(baseUrl: Env.apiUrl);
  }

  /// The cache options.
  final cache = CacheOptions(
    // The path is null because Hive was already initialized.
    store: AppInjector.isTest ? null : HiveCacheStore(null),
    policy: CachePolicy.refreshForceCache, // server first
    hitCacheOnErrorExcept: [], // return cache on any error
    maxStale: 7.days,
  );

  /// Gets the authorization token.
  String? get token => options.headers['authorization'] as String?;

  /// Sets the authorization token.
  set token(String? value) {
    options.headers['authorization'] = switch (value) {
      null => options.headers.remove('authorization'),
      var token => 'Bearer $token',
    };
  }

  @override
  Interceptors get interceptors => Interceptors()
    ..addAll([
      // Logs requests and responses.
      PrettyDioLogger(
        maxWidth: 50,
        requestBody: true,
        logPrint: (o) => dev.log('$o', name: 'dio'),
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
      if (!AppInjector.isTest) DioCacheInterceptor(options: cache),
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
        },
      ),

      // ApiException wrapper.
      InterceptorsWrapper(
        onError: (e, handler) => handler.next(ApiException.from(e)),
      ),
    ]);

  /// Upload a file to server, returns the url.
  Future<String> upload(XFile file) async {
    final response = await post<Map>(
      '/uploads',
      data: await uploadData(file),
    );

    if (response.data?['file'] case {'url': String url}) return url;
    throw Exception('Falha ao fazer upload do arquivo.');
  }

  /// Creates a FormData object from a file.
  Future<FormData> uploadData(XFile file, {String field = 'file'}) async {
    return FormData.fromMap({
      field: MultipartFile.fromBytes(
        await file.readAsBytes(),
        filename: file.name,
        contentType: switch (file.mimeType ?? lookupMimeType(file.name)) {
          null => null,
          var type => MediaType.parse(type),
        },
      ),
    });
  }

  /// Extra options.
  /// - forceCache: Always return cache, when available.
  /// - mock: Mock the response, when in debug mode.
  Map<String, dynamic> extra({Object? mock, bool forceCache = false}) {
    return {
      if (forceCache)
        ...cache.copyWith(policy: CachePolicy.forceCache).toExtra(),
      if (kDebugMode) ...{'@mock@': mock},
    };
  }
}

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
  String get message => switch (response?.data) {
        {'message': String message} => message,
        {'message': List list} when list.isNotEmpty => '${list.first}',
        _ => super.message ?? type.name,
      };
}

@visibleForTesting
Future<String> jlog(Object? object) async {
  final json = const JsonEncoder.withIndent('  ').convert(object);
  await Clipboard.setData(ClipboardData(text: json));

  return json;
}
