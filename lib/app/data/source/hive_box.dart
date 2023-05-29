import 'dart:async';
import 'dart:convert';

import 'package:branvier/branvier.dart';
import 'package:hive/hive.dart';

///Super fast cached preferences.
class HiveBox implements IBox {
  late final Box _storage = Hive.box('box');

  static Future<void> init() async {
    Hive.init('storage');
    await Hive.openBox('box');
  }

  @override
  T? read<T>(String key, {or}) {
    try {
      final data = _storage.get(key);
      if (data != null) return jsonEncode(data).parse<T>();
      if (data == null && or != null) write(key, or);
      return data ?? or;
    } catch (e) {
      delete(key);
      rethrow;
    }
  }

  @override
  Future<void> write(String key, data) => _storage.put(key, data);

  @override
  Future<void> delete(String key) => _storage.delete(key);

  @override
  Future<void> deleteAll() => _storage.clear();

  @override
  Json readAll() => Json.from(_storage.toMap());
}
