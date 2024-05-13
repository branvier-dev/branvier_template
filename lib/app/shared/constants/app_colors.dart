import 'package:flutter/material.dart';

extension AppColors on ColorScheme {
  static ColorScheme get light => ColorScheme.fromSeed(
        seedColor: Colors.yellow,
  );
  static ColorScheme get dark => ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Colors.yellow,
      );
}
