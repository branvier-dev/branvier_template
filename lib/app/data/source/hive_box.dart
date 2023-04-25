import 'dart:async';

import 'package:branvier/branvier.dart';
import 'package:hive/hive.dart';

///Super fast cached preferences.
class HiveBox implements IOpenBox {
  late final Box _storage;

  Future<HiveBox> init() async {
    Hive.init('open');
    _storage = await Hive.openBox('box');
    return this;
  }

  @override
  T? read<T>(String key, {or}) {
    final data = _storage.get(key);
    if (data == null && or != null) unawaited(write(key, or));
    return data ?? or;
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
