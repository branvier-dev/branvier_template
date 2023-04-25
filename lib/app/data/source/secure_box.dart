import 'dart:async';
import 'dart:convert';

import 'package:branvier/branvier.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///Stores encrypted data in the cache.
class SecureBox implements ISafeBox {
  final _storage = const FlutterSecureStorage();

  @override
  Future<T?> read<T>(key, {or}) async {
    final data = await _storage.read(key: key);
    if (data == null && or != null) await write(key, or);
    return data?.parse<T>() ?? or;
  }

  @override
  Future<void> write(key, value) =>
      _storage.write(key: key, value: jsonEncode(value));

  @override
  Future<void> delete(key) => _storage.delete(key: key);

  @override
  Future<void> deleteAll() => _storage.deleteAll();

  @override
  Future<Json> readAll() async {
    final all = await _storage.readAll();
    return all.map((key, value) => jsonDecode(value));
  }
}
