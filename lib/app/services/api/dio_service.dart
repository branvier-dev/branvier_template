// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logarte/logarte.dart';
import 'package:mime/mime.dart';
import 'package:provide_it/provide_it.dart';

import '../../../env.dart';
import '../../app_analytics.dart';
import '../../app_router.dart';
import '../../features/auth/repositories/auth_repository.dart';
import '../../features/auth/views/login_page.dart';
import 'api_exception.dart';

class DioService extends DioMixin {
  DioService() {
    httpClientAdapter = HttpClientAdapter();
    interceptors.addAll([ErrorInterceptor(), LogarteDioInterceptor(logarte)]);
  }

  @override
  BaseOptions get options => BaseOptions(
    baseUrl: Env.apiUrl,
    // headers: {'ngrok-skip-browser-warning': '69420'},
  );

  String? get token =>
      options.headers['authorization']?.toString().replaceFirst('Bearer ', '');

  set token(String? value) {
    options.headers['authorization'] = switch (value) {
      null => options.headers.remove('authorization'),
      var token when token.startsWith('Bearer ') => token,
      var token => 'Bearer $token',
    };
  }

  /// Faz upload de [file] e obtem sua `url`.
  /// - Atualize [path], [key] e `data.url` de acordo com o servidor.
  Future<String> upload(
    XFile file, {
    String path = '/uploads',
    String key = 'file',
  }) async {
    final bytes = await file.readAsBytes();
    final header = bytes.sublist(0, 12);

    final response = await post<Map>(
      path,
      data: FormData.fromMap({
        key: MultipartFile.fromBytes(
          bytes,
          filename: file.name,
          contentType: MediaType.parse(
            file.mimeType ?? lookupMimeType(file.name, headerBytes: header)!,
          ),
        ),
      }),
    );

    if (response.data?[key] case {'url': String url}) return url;
    throw Exception('Falha ao fazer upload do arquivo.');
  }
}

typedef UploadCallback = Future<String> Function(XFile xfile);

@visibleForTesting
Future<String> jlog(Object? object) async {
  final json = const JsonEncoder.withIndent('  ').convert(object);
  await Clipboard.setData(ClipboardData(text: json));

  return json;
}

class ErrorInterceptor extends Interceptor {
  ErrorInterceptor();

  @override
  Future<void> onError(err, handler) async {
    if (err.response?.statusCode == 401) {
      await readIt<AuthRepository>().logout();
      goRouter.goNamed(LoginPage.name);
    }

    super.onError(ApiException.from(err), handler);
  }
}
