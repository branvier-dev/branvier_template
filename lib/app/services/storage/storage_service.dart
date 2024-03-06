import 'dart:async';

abstract class StorageService {
  String? get(String key);
  Future<void> set(String key, String value);
  Future<void> remove(String key);
  Future<void> clear();
}
