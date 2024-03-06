import 'package:flutter/material.dart';

import '../../services/storage/storage_service.dart';

class ThemeRepository {
  const ThemeRepository(this.storage);

  final StorageService storage;

  ThemeMode getMode() {
    final name = storage.get('theme_mode');

    return ThemeMode.values.byName(name ?? 'light');
  }

  void setMode(ThemeMode value) {
    storage.set('theme_mode', value.name);
  }
}
