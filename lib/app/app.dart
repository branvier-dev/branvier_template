import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:formx/formx.dart';
import 'package:provider/provider.dart';
import 'package:tr_extension/tr_extension.dart';

import 'app_router.dart';
import 'core/stores/theme_store.dart';
import 'shared/constants/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Formx.disableValidatorsOnDebugMode = true;
    Animate.restartOnHotReload = true;
    Validator.translator = (key, errorText) => '$errorText.$key'.tr;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      // Localization
      localizationsDelegates: TrDelegate().toList(),
      locale: context.locale,
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],

      // Theme
      themeMode: context.watch<ThemeStore>().mode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

      // Routes
      routerConfig: AppRouter.config,

      // Overlays
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).focusedChild?.unfocus(),
          child: child,
        );
      },
    );
  }
}
