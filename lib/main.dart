// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/app_injector.dart';
import 'app/core/stores/theme_store.dart';
import 'app/features/auth/stores/auth_store.dart';
import 'app/shared/widgets/app_error.dart';
import 'app/shared/widgets/app_splash.dart';

void main() async {
  try {
    runApp(const AppSplash());
    usePathUrlStrategy();

    // Framework
    App.info = await PackageInfo.fromPlatform();

    // Injector & Locator
    final i = await AppInjector.setup();

    runApp(
      MultiProvider(
        providers: [
          StoreProvider(create: (_) => AuthStore(i())),
          StoreProvider(create: (_) => ThemeStore(i())),
        ],
        child: const App(),
      ),
    );
  } catch (e, s) {
    runApp(AppError(error: e, stackTrace: s, onRetry: main));
  }
}

typedef StoreProvider<T extends ChangeNotifier> = ChangeNotifierProvider<T>;
