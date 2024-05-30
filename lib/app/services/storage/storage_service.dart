import 'dart:async';

abstract class StorageService {
  factory StorageService() => StorageServiceMock();
  String? get(String key);
  Future<void> set(String key, String value);
  Future<void> remove(String key);
  Future<void> clear();
}

class StorageServiceMock implements StorageService {
  final Map<String, String> _storage = {};

  @override
  String? get(String key) => _storage[key];

  @override
  Future<void> set(String key, String value) async => _storage[key] = value;

  @override
  Future<void> remove(String key) async => _storage.remove(key);

  @override
  Future<void> clear() async => _storage.clear();
}
