import 'package:flutter/material.dart';

import 'app_colors.dart';

mixin AppTheme {
  static TextTheme get texts => const TextTheme();

  // Theme Base
  @protected
  static ThemeData get base => ThemeData(
        textTheme: texts,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          constraints: BoxConstraints(maxWidth: 600),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            hoverColor: Colors.grey.withOpacity(0.2),
            padding: const EdgeInsets.all(2),
            minimumSize: const Size(4, 4),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            minimumSize: const Size(32, 32),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
        ),
      );

  // Theme Light
  static ThemeData get light => base.copyWith(
        colorScheme: AppColors.light,
        // *
        inputDecorationTheme: base.inputDecorationTheme.copyWith(
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 1.4),
          ),
          // * Border OFF
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.light.onBackground.withOpacity(0.6),
              width: 1.4,
            ),
          ),
          // * Border ON
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.light.primary,
              width: 1.8,
            ),
          ),
          // * Border ERROR
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.light.error,
              width: 1.8,
            ),
          ),
          // * Border ERROR FOCUSED
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.light.error,
              width: 1.8,
            ),
          ),
        ),
      );

  // * Theme Dark
  static ThemeData get dark => base.copyWith(colorScheme: AppColors.dark);
}
