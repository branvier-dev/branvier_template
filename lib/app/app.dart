// ignore_for_file: avoid_late_keyword
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_async/flutter_async.dart';
import 'package:formx/formx.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tr_extension/tr_extension.dart';

import 'app_router.dart';
import 'shared/constants/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  static late final PackageInfo info;

  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload = true;
    Validator.translator = (key, errorText) => '$errorText.$key'.tr;
    Async.translator = (e) => switch (e) {
          ArgumentError(:String name) => 'form.invalid.$name'.tr,
          _ => Async.defaultMessage(e),
        };

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

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
