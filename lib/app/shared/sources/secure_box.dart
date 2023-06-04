import 'dart:async';
import 'dart:convert';

import 'package:branvier_template/app/shared/sources/interfaces/box_interface.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureBox implements IAsyncBox {
  final _storage = const FlutterSecureStorage();

  @override
  Future<T?> read<T>(key) async {
    final value = await _storage.read(key: key);
    return value != null ? jsonDecode(value) as T? : null;
  }

  @override
  Future<void> write(key, value) async {
    _storage.write(key: key, value: jsonEncode(value));
  }

  @override
  Future<void> delete(key) => _storage.delete(key: key);

  @override
  Future<void> deleteAll() => _storage.deleteAll();

  @override
  Future<Map<String, dynamic>> readAll() async {
    final all = await _storage.readAll();
    return all.map((key, value) => MapEntry(key, jsonDecode(value)));
  }
}
