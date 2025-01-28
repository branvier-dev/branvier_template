import 'package:flutter/material.dart';
import 'package:tr_extension/tr_extension.dart';

import '../env.dart';
import 'app_router.dart';
import 'shared/constants/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: Env.isDev,

      // Localization
      localizationsDelegates: TrDelegate().toList(),
      locale: context.locale,
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],

      // Theme
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

      // Routes
      routerConfig: AppRouter.config,

      // * Overlays
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).focusedChild?.unfocus(),
            child: child,
          ),
        );
      },
    );
  }
}
