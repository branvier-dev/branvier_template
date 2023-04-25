import 'package:branvier/state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/colors.dart';
import '../../data/repositories/theme_repository.dart';

class ThemeService {
  ThemeService(this._repository);
  final ThemeRepository _repository;

  //State
  final _data = ThemeData().obs;

  //Current theme data.
  ThemeData get data => _data.value;

  ///Init the [ThemeService].
  Future<ThemeService> init() async {
    _data.value = _repository.getTheme();
    await GoogleFonts.pendingFontLoads();
    return this;
  }

  ///Changes the [AppColors] and sets the [ThemeData] state.
  void changeColors(AppColors colors) {
    _repository.setColors(colors);
    _data.value = _repository.getTheme();
  }

  ///Changes the [ThemeMode] and sets the [ThemeData] state.
  void changeMode(ThemeMode mode) {
    _repository.setMode(mode);
    _data.value = _repository.getTheme();
  }
}
