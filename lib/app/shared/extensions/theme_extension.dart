// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

extension ThemeExtension on ThemeData {
  /// Applies [radius] to all components.
  ///
  /// You can override the default radius setting:
  /// - [cardRadius] for [CardTheme]
  /// - [inputRadius] for [InputDecorationTheme]
  /// - [modalRadius] for [BottomSheetThemeData], [DatePickerThemeData], [TimePickerThemeData], [DialogTheme], [DrawerTheme], [NavigationDrawerThemeData]
  /// - [buttonRadius] for [ButtonThemeData], [ChipThemeData], [FloatingActionButtonThemeData], [ElevatedButtonThemeData], [OutlinedButtonThemeData], [TextButtonThemeData], [FilledButtonThemeData], [SegmentedButtonThemeData]
  ///
  /// Does not apply to [SnackBarThemeData], [NavigationRailThemeData].
  ///
  ThemeData withRadius(
    double radius, {
    double? buttonRadius,
    double? cardRadius,
    double? inputRadius,
    double? modalRadius,
  }) {
    final btnRadius = BorderRadius.all(Radius.circular(buttonRadius ?? radius));
    final buttonShape = RoundedRectangleBorder(borderRadius: btnRadius);
    final buttonStyle = ButtonStyle(shape: buttonShape.property);

    final modalShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(modalRadius ?? radius)),
    );

    return copyWith(
      // Button
      chipTheme: chipTheme.copyWith(shape: buttonShape),
      buttonTheme: buttonTheme.copyWith(shape: buttonShape),
      toggleButtonsTheme: toggleButtonsTheme.copyWith(borderRadius: btnRadius),
      floatingActionButtonTheme:
          floatingActionButtonTheme.copyWith(shape: buttonShape),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: buttonStyle.merge(elevatedButtonTheme.style),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: buttonStyle.merge(outlinedButtonTheme.style),
      ),
      textButtonTheme: TextButtonThemeData(
        style: buttonStyle.merge(textButtonTheme.style),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: buttonStyle.merge(filledButtonTheme.style),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: buttonStyle.merge(segmentedButtonTheme.style),
      ),
      menuButtonTheme: MenuButtonThemeData(style: buttonStyle),
      menuBarTheme: MenuBarThemeData(
        style: MenuStyle(shape: buttonShape.property).merge(menuBarTheme.style),
      ),

      // Card
      cardTheme: cardTheme.copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(cardRadius ?? radius)),
        ),
      ),

      // Input
      inputDecorationTheme: inputDecorationTheme.copyWith(
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(inputRadius ?? radius)),
        ),
      ),

      // Modal
      menuTheme: MenuThemeData(
        style: MenuStyle(shape: modalShape.property).merge(menuTheme.style),
      ),
      bottomSheetTheme: bottomSheetTheme.copyWith(shape: modalShape),
      datePickerTheme: datePickerTheme.copyWith(shape: modalShape),
      timePickerTheme: timePickerTheme.copyWith(shape: modalShape),
      dialogTheme: dialogTheme.copyWith(shape: modalShape),
      drawerTheme: drawerTheme.copyWith(shape: modalShape),
      popupMenuTheme: popupMenuTheme.copyWith(shape: modalShape),
      navigationDrawerTheme:
          navigationDrawerTheme.copyWith(indicatorShape: modalShape),
    );
  }
}

extension StatePropertyExtension<T> on T {
  // ignore: deprecated_member_use
  MaterialStateProperty<T> get property => MaterialStatePropertyAll(this);
}
