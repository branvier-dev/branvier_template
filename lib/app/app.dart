import 'package:flutter/material.dart';
import 'package:flutter_async/flutter_async.dart';
import 'package:formx/formx.dart';
import 'package:tr_extension/tr_extension.dart';

import '../env.dart';
import 'app_router.dart';
import 'shared/constants/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key, this.builder});
  final WidgetBuilder? builder;

  @override
  Widget build(BuildContext context) {
    Validator.translator = (key, errorText) => '$errorText.$key'.tr;
    Async.translator = (e) => switch (e) {
      ArgumentError(:String name) => 'form.invalid.$name'.tr,
      _ => Async.defaultMessage(e),
    };

    return MaterialApp.router(
      // Routes
      routerConfig: goRouter,

      // Theme
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

      // Localization
      locale: context.locale,
      localizationsDelegates: TrDelegate(),
      supportedLocales: const [Locale('pt', 'BR')],

      // Overlays
      debugShowCheckedModeBanner: Env.current == Env.development,
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
                Env.version,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
