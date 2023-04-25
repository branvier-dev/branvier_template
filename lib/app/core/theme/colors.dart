import 'package:flutter/material.dart';

/// The colors of the app in [ColorScheme].
///
/// For each new theme create another [ColorScheme].
abstract class IColors implements Enum {
  const IColors(this.light, this.dark);

  ///The [ColorScheme] for light theme.
  final ColorScheme light;

  ///The [ColorScheme] for dark theme.
  final ColorScheme dark;
}

enum AppColors implements IColors {
  base(
    ColorScheme.light(
      primary: Color(0xFFF6D743),
      secondary: Color(0xFF2979FF),
      background: Color(0xFFF8F8F8),
    ),
    ColorScheme.dark(
      primary: Color(0xFFF6D743),
      secondary: Color(0xFFFFC107),
      background: Color(0xFF212121),
    ),
  ),

  stevenUniverse(
    ColorScheme.light(
      primary: Color(0xFFF5A623),
      secondary: Color(0xFF00BFFF),
      background: Color(0xFFF8F8F8),
    ),
    ColorScheme.dark(
      primary: Color(0xFFF5A623),
      secondary: Color(0xFFD8BFD8),
      background: Color(0xFF212121),
    ),
  ),

  halloween(
    ColorScheme.light(
      primary: Color(0xFFFF5733), // orange
      secondary: Color(0xFF6A5ACD), // purple
      background: Color(0xFF1E1E1E), // black
    ),
    ColorScheme.dark(
      primary: Color(0xFFFF5733), // orange
      secondary: Color(0xFF6A5ACD), // purple
      background: Color(0xFFEDEDED), // off-white
    ),
  ),

  christmas(
    ColorScheme.light(
      primary: Color(0xFFE63946), // red
      secondary: Color(0xFF457B9D), // blue
      background: Color(0xFFF1FAEE), // light green
    ),
    ColorScheme.dark(
      primary: Color(0xFFE63946), // red
      secondary: Color(0xFF457B9D), // blue
      background: Color(0xFF1D3557), // dark blue
    ),
  );

  const AppColors(this.light, this.dark);

  @override
  final ColorScheme light;

  @override
  final ColorScheme dark;
}
