import 'package:flutter/material.dart';

/// Aqui ficam todas as cores do app. Deve ser usado para manter a consistência
/// das cores no app, seja em temas ou componentes.
///
/// Evite usar cores diretamente no código, use sempre as cores daqui.
/// Ex: `final colors = Theme.of(context).colorScheme`.
extension AppColors on ColorScheme {
  static ColorScheme get light => ColorScheme.fromSeed(
        dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
        seedColor: Colors.yellow,
      );
  static ColorScheme get dark => ColorScheme.fromSeed(
        dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
        brightness: Brightness.dark,
        seedColor: Colors.yellow,
      );
}
