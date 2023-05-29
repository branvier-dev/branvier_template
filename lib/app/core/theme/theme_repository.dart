import 'package:branvier/branvier.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'theme.dart';

/// [ThemeRepository] encapsulates all data processing of [Theme].
class ThemeRepository {
  ThemeRepository(this._box);
  static const key = 'theme';

  //Dependencies
  final IBox _box;

  ///Gets the [ThemeData] on cache.
  ThemeData getTheme() {
    final colors = getColors();
    final mode = getMode();

    if (mode == ThemeMode.light) return AppTheme(colors.light).data();
    if (mode == ThemeMode.dark) return AppTheme(colors.dark).data();

    //Getting system theme via kIsDark.
    return AppTheme(kIsDark ? colors.dark : colors.light).data();
  }

  ///Gets the [ThemeMode] on cache.
  ThemeMode getMode() {
    final name = _box.read('$key.mode', or: 'system')!;
    return ThemeMode.values.byName(name);
  }

  ///Sets the [ThemeMode] on cache.
  void setMode(ThemeMode mode) async {
    await _box.write('$key.mode', mode.name);
  }

  ///Gets the [AppColors] on cache.
  AppColors getColors() {
    final name = _box.read('$key.colors', or: 'base')!;
    return AppColors.values.byName(name);
  }

  ///Sets the [AppColors] on cache.
  void setColors(AppColors colors) async {
    await _box.write('$key.colors', colors.name);
  }
}
