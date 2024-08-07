// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../../env.dart';
import 'dio_interceptors.dart';

typedef UploadCallback = Future<String> Function(XFile xfile);

class DioService extends DioMixin {
  DioService() {
    httpClientAdapter = HttpClientAdapter();
    options = BaseOptions(baseUrl: Env.apiUrl);
  }

  @override
  final DioInterceptors interceptors = DioInterceptors();

  /// Gets the authorization token.
  String? get token => options.headers['authorization'] as String?;

  /// Sets the authorization token.
  set token(String? value) {
    options.headers['authorization'] = switch (value) {
      null => options.headers.remove('authorization'),
      var token => 'Bearer $token',
    };
  }

  /// Atalho para realizar upload de arquivos.
  /// Atualize o path, key e o retorno do arquivo de acordo com a API.
  Future<String> upload(
    XFile file, {
    String path = '/uploads',
    String key = 'file',
  }) async {
    final response = await post<Map>(
      path,
      data: FormData.fromMap({
        key: MultipartFile.fromBytes(
          await file.readAsBytes(),
          filename: file.name,
          contentType: MediaType.parse(
            file.mimeType ?? lookupMimeType(file.name)!,
          ),
        ),
      }),
    );

    if (response.data?['file'] case {'url': String url}) return url;
    throw Exception('Falha ao fazer upload do arquivo.');
  }

  /// Extra options.
  /// - forceCache: Always return cache, when available.
  /// - mock: Mock the response, when in debug mode.
  Map<String, dynamic> extra({Object? mock, bool forceCache = false}) {
    return {
      if (forceCache)
        ...interceptors.cache
            .copyWith(policy: CachePolicy.forceCache)
            .toExtra(),
      if (kDebugMode) ...{'@mock@': mock},
    };
  }
}

@visibleForTesting
Future<String> jlog(Object? object) async {
  final json = const JsonEncoder.withIndent('  ').convert(object);
  await Clipboard.setData(ClipboardData(text: json));

  return json;
}
