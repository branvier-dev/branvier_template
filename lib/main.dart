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

    // Setup
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Dependency Injection
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
