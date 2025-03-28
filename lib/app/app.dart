import 'package:flutter/material.dart';
import 'package:tr_extension/tr_extension.dart';

import '../env.dart';
import 'app_router.dart';
import 'app_setup.dart';
import 'shared/constants/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key, this.builder});
  final WidgetBuilder? builder;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: Env.isDev,

      // Localization
      localizationsDelegates: TrDelegate(),
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

      // Overlays
      builder: (_, child) => AppBuilder(builder ?? (_) => child!),
    );
  }
}

class AppBuilder extends StatelessWidget {
  const AppBuilder(this.builder, {super.key});
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).focusedChild?.unfocus(),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              builder(context),
              Text(
                AppSetup.version,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
