import 'dart:async';

import 'cache_service.dart';

class CacheServiceFake extends CacheService {
  final _cache = <String, String>{};

  @override
  String? get(String key) => _cache[key];

  @override
  Future<void> set(String key, String value) async {
    _cache[key] = value;
    refresh();
  }

  @override
  Future<void> remove(String key) async {
    _cache.remove(key);
    refresh();
  }

  @override
  Future<void> clear() async {
    _cache.clear();
    refresh();
  }
}
