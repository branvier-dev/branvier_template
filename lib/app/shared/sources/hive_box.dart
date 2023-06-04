import 'dart:async';

import 'package:hive/hive.dart';

import 'interfaces/box_interface.dart';

class HiveBox implements IBox {
  final Box _storage = Hive.box('box');

  static Future<void> init() async {
    Hive.init('storage');
    await Hive.openBox('box');
  }

  @override
  T? read<T>(String key) {
    try {
      return _storage.get(key);
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
  Map<String, dynamic> readAll() => Map<String, dynamic>.from(_storage.toMap());
}
