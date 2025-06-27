import 'dart:convert';

import 'package:dio/dio.dart';

import 'cache_service.dart';

class CacheInterceptor extends Interceptor {
  CacheInterceptor(this.cache, {this.expiry = const Duration(minutes: 10)});
  final CacheService cache;
  final Duration expiry;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method == 'GET') {
      final key = _key(options);
      final cached = cache.get(key);
      if (cached != null) {
        final data = jsonDecode(cached) as Map<String, dynamic>;
        if (DateTime.parse(data['expiry'] as String).isAfter(DateTime.now())) {
          return handler.resolve(
            Response(
              requestOptions: options,
              data: data['value'],
              statusCode: 200,
            ),
          );
        }
        cache.remove(key);
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.method == 'GET' && response.statusCode == 200) {
      final key = _key(response.requestOptions);
      final data = {
        'value': response.data,
        'expiry': DateTime.now().add(expiry).toIso8601String(),
      };
      cache.set(key, jsonEncode(data));
    }
    handler.next(response);
  }

  String _key(RequestOptions options) => '${options.uri}';
}
