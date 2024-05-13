import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/theme_repository.dart';

class ThemeStore extends ChangeNotifier implements ReassembleHandler {
  ThemeStore(this._repository);

  final ThemeRepository _repository;

  // ThemeMode get mode => _repository.getMode();
  ThemeMode get mode => ThemeMode.light;

  void setMode(ThemeMode value) {
    _repository.setMode(value);
    notifyListeners();
  }

  @override
  void reassemble() {
    notifyListeners();
  }
}
