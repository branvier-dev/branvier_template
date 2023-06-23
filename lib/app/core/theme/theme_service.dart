import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'theme_repository.dart';

class ThemeService {
  ThemeService(this._repository) {
    init();
  }
  final ThemeRepository _repository;

  //State
  final _data = Atom(ThemeData());

  //Current theme data.
  ThemeData get data => _data.value;

  ///Init the [ThemeService].
  void init() {
    _data.value = _repository.getTheme();
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
