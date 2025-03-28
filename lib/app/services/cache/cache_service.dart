import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class CacheService {
  final _controller = StreamController<Map<String, String?>>();
  final _keys = <String>{};

  String? get(String key);
  Future<void> set(String key, String value);
  Future<void> remove(String key);
  Future<void> clear();

  Stream<String?> getStream(String key) {
    _keys.add(key);
    refresh();

    return _controller.stream.map((map) => map[key]).distinct();
  }

  /// Refreshes the stream with the current values.
  ///
  /// Should be called by [set], [remove], [clear] and any other cache modifier.
  void refresh() {
    _controller.add({for (final key in _keys) key: get(key)});
  }

  @mustCallSuper
  void dispose() {
    _controller.close();
  }
}
