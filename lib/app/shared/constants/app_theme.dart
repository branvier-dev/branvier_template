import 'package:flutter/material.dart';

import 'app_colors.dart';

extension AppTheme on ThemeData {
  static ThemeData get light => AppColors.light.theme;
  static ThemeData get dark => AppColors.dark.theme;

  /// Whether this theme is dark.
  bool get isDark => brightness == Brightness.dark;
}

extension on ColorScheme {
  /// Aqui criamos o nosso tema [ThemeData] a partir do [ColorScheme] atual,
  /// dessa forma o mesmo tema será aplicado em ambos esquemas de cores.
  ///
  /// Caso precise usar uma cor de acordo com o esquema de cores, você pode
  /// acessar as propriedades [primary], [secondary], etc, diretamente, ou use a
  /// propriedade `isDark` e faça a lógica desejada.
  ///
  /// Procure centralizar as customizações dos componentes aqui primeiro. Acesse
  /// o tema atual usando [Theme.of]. Ex: `Theme.of(context).textTheme`.
  ThemeData get theme {
    return ThemeData(
      colorScheme: this,

      // O Flutter muda os valores abaixo de acordo com a plataforma. Isso não
      // é desejado, então definimos os valores manualmente.
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,

      // Components
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.red,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        isDense: true,
        constraints: BoxConstraints(maxWidth: 600),
      ),
    );
  }
}
