import 'package:flutter/material.dart';

import '../extensions/theme_extension.dart';
import 'app_colors.dart';

extension AppTheme on ThemeData {
  static ThemeData get light => AppColors.light.theme;
  static ThemeData get dark => AppColors.dark.theme;

  /// Whether this theme is dark.
  bool get isDark => brightness == Brightness.dark;
}

extension on ColorScheme {
  /// Creates a [ThemeData] from this [ColorScheme].
  ThemeData get theme {
    return ThemeData(
      colorScheme: this,

      // General
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,

      // Components
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        isDense: true,
        constraints: BoxConstraints(maxWidth: 600),
      ),
    ).withRadius(8.0);
  }
}
