import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class ITheme {
  ITheme(this.colors);

  ///Contains all the app colors.
  final ColorScheme colors;

  ///Contains all the text styles.
  TextTheme get font;

  ///Contains all widget themes.
  ThemeData get overrides;
}

extension ThemeExtension on ITheme {
  ///The [ThemeData] used on app [Theme].
  ThemeData data() => overrides.copyWith(colorScheme: colors, textTheme: font);
}

class AppTheme implements ITheme {
  const AppTheme(this.colors);

  @override

  ///The current selected [ColorScheme] theme.
  final ColorScheme colors;

  @override
  TextTheme get font => GoogleFonts.montserratTextTheme();

  @override
  // * Theme Overrides:
  // *
  // * This will also override the colors and text style !
  // * Use [colors] to get the current theme colors.
  // * Use [font] to retrieve the font styles.
  // *
  ThemeData get overrides => ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.4,
              color: colors.primary, // * example
            ),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
}
