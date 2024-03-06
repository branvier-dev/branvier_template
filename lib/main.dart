// ignore_for_file: unreachable_from_main

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    // setup
    await [
      Future.delayed(AppSplash.duration),

      // Framework
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),

      // Dependency Injection
      AppInjector.setup(),
    ].wait;

    final i = AppInjector.i;

    runApp(
      MultiProvider(
        providers: [
          // Use Cases

          // Stores
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
