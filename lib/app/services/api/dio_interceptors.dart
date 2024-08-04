import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app_injector.dart';
import 'api_exception.dart';

class DioInterceptors extends Interceptors {
  DioInterceptors() {
    addAll([
      PrettyDioLogger(
        requestBody: true,
        filter: (_, args) {
          if (args.data case List list) {
            if (kDebugMode) {
              print(
                'Filtered List.first [length: ${list.length}]:\n'
                '${list.firstOrNull}',
              );
            }
          }

          return args.hasMapData || args.hasStringData;
        },
      ),
      MockInterceptor(),
      if (!kIsTest) DioCacheInterceptor(options: cache),
      ResponseInterceptor(),
      InterceptorsWrapper(
        onError: (e, handler) => handler.next(ApiException.from(e)),
      ),
    ]);
  }

  final cache = CacheOptions(
    // The path is null because Hive was already initialized.
    store: kIsTest ? null : HiveCacheStore(null),
    policy: CachePolicy.refreshForceCache, // server first
    hitCacheOnErrorExcept: [], // return cache on any error
    maxStale: 7.days,
  );
}

class MockInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
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
  }
}

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(
        switch (response.extra) {
          {'@fromMock@': true} => 'Source: mock',
          {'@fromNetwork@': false} => 'Source: cache',
          _ => 'Source: network',
        },
      );
    }
    handler.next(response);
  }
}
