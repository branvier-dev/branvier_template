// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../env.dart';
import 'api_exception.dart';

class DioService extends DioMixin {
  DioService() {
    options = BaseOptions(baseUrl: Env.apiUrl);
    httpClientAdapter = HttpClientAdapter();
    interceptors.addAll([
      PrettyDioLogger(),
      InterceptorsWrapper(onError: (e, h) => h.next(ApiException.from(e))),
    ]);
  }

  /// Gets the authorization token.
  String? get token {
    final token = options.headers['authorization'] as String?;

    return token?.replaceFirst('Bearer ', '');
  }

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
