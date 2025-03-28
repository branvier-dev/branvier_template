import 'dart:convert';

import 'package:dio/dio.dart';

import 'cache_service.dart';

// TODO(Art): working in progress
class CachingInterceptor extends Interceptor {
  CachingInterceptor(
    CacheService cache, {
    this.cacheDuration = const Duration(minutes: 10),
  }) : cache = NetworkCacheService(cache);

  final Duration cacheDuration;
  final NetworkCacheService cache;

  @override
  Future<void> onRequest(options, handler) async {
    final cacheKey = options.uri.toString();
    final cachedEntry = await cache.getEntry(cacheKey);

    if (cachedEntry != null) {
      final response = _buildResponse(cachedEntry, options);

      return handler.resolve(response);
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(err, handler) async {
    final cacheKey = err.requestOptions.uri.toString();
    final cachedEntry = await cache.getEntry(cacheKey);

    if (cachedEntry != null) {
      final response = _buildResponse(cachedEntry, err.requestOptions);

      return handler.resolve(response);
    }

    return handler.next(err);
  }

  @override
  Future<void> onResponse(response, handler) async {
    final statusCode = response.statusCode;

    // Only cache successful responses
    if (statusCode != null && statusCode >= 200 && statusCode < 300) {
      final entry = NetworkCacheEntry.fromResponse(
        response,
        cacheDuration,
      );
      await cache.putEntry(entry);
    }

    return handler.next(response);
  }

  Response _buildResponse(
    NetworkCacheEntry cachedEntry,
    RequestOptions options,
  ) {
    return Response(
      requestOptions: options,
      statusCode: cachedEntry.statusCode,
      data: cachedEntry.value,
    );
  }
}

class NetworkCacheService {
  NetworkCacheService(this.cache);
  final CacheService cache;

  Future<NetworkCacheEntry?> getEntry(String key) async {
    final cachedEntry = cache.get(key);
    if (cachedEntry == null) return null;

    final entry = NetworkCacheEntry.fromJson(
      jsonDecode(cachedEntry) as Map<String, dynamic>,
    );

    // Remove expired entries
    if (!entry.isValid) {
      await cache.remove(entry.key);

      return null;
    }

    return entry;
  }

  Future<void> putEntry(NetworkCacheEntry entry) async {
    final json = jsonEncode(entry.toJson());

    return cache.set(entry.key, json);
  }
}

class NetworkCacheEntry {
  const NetworkCacheEntry({
    required this.key,
    required this.statusCode,
    required this.value,
    required this.expiry,
  });

  factory NetworkCacheEntry.fromResponse(
    Response response,
    Duration cacheDuration,
  ) {
    return NetworkCacheEntry(
      key: response.requestOptions.uri.toString(),
      statusCode: response.statusCode,
      value: response.data,
      expiry: DateTime.now().add(cacheDuration),
    );
  }

  factory NetworkCacheEntry.fromJson(Map<String, dynamic> json) {
    return NetworkCacheEntry(
      key: json['key'] as String,
      statusCode: json['statusCode'] as int?,
      value: json['value'],
      expiry: DateTime.parse(json['expiry'] as String),
    );
  }

  final String key;
  final int? statusCode;
  final dynamic value;
  final DateTime expiry;

  bool get isValid => expiry.isAfter(DateTime.now());

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'statusCode': statusCode,
      'value': value,
      'expiry': expiry.toIso8601String(),
    };
  }
}
