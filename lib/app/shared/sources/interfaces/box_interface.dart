import 'dart:async';

import 'package:mocktail/mocktail.dart';

/// Synchronous key/value storage interface.
abstract class IBox implements IAsyncBox {
  @override
  T? read<T>(String key);
  @override
  Map<String, dynamic> readAll();
}

/// Asynchronous key/value storage interface.
abstract class IAsyncBox {
  /// Reads [key], if null, sets and gets [or].
  FutureOr<T?> read<T>(String key);

  /// Gets all data.
  FutureOr<Map<String, dynamic>> readAll();

  /// Writes [data] in [key].
  Future<void> write(String key, data);

  /// Removes data in [key].
  Future<void> delete(String key);

  /// Clear all data.
  Future<void> deleteAll();
}

/// Storage extension.
extension BoxExtension on IAsyncBox {
  /// Gets current data and sets with [update].
  Future<void> update<T>(String key, T update(T? data)) async {
    final newData = update(await read(key));
    await write(key, newData);
  }
} // tested

/// Simple fake key/value storage mock.
class FakeBox extends Mock implements IBox, IAsyncBox {
  /// Functional FakeBox. You can start with [initialData] content.
  FakeBox([this.initialData = const {}]) {
    storage.addAll(initialData);
  }

  /// Fake storage.
  final Map<String, dynamic> storage = {};
  final Map<String, dynamic> initialData;

  @override
  T? read<T>(key, {or}) => storage[key] ?? write(key, or).then((_) => or);

  @override
  Map<String, dynamic> readAll() => storage;

  @override
  Future<void> delete(key) async => storage.remove(key);

  @override
  Future<void> deleteAll() async => storage.clear();

  @override
  Future<void> write(key, data) async => storage[key] = data;
}
