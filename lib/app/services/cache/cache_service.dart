import 'dart:async';

abstract class CacheService {
  String? get(String key);
  Future<void> set(String key, String value);
  Future<void> remove(String key);
  Future<void> clear();
}

class FakeCacheService implements CacheService {
  final _cache = <String, String>{};

  @override
  String? get(String key) => _cache[key];

  @override
  Future<void> set(String key, String value) async => _cache[key] = value;

  @override
  Future<void> remove(String key) async => _cache.remove(key);

  @override
  Future<void> clear() async => _cache.clear();
}
