import 'package:asp/asp.dart';
import 'package:asuka/asuka.dart';
import 'package:branvier/branvier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/theme/theme_service.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  ThemeService get theme => Modular.get();

  @override
  void initState() {
    Modular.setObservers([Asuka.asukaHeroController]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //Theme
      theme: context.select(() => theme.data),
      builder: Asuka.builder,

      //Translation
      localizationsDelegates: Translation.delegates,

      //Routes
      // routerConfig: Modular.routerConfig,
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
