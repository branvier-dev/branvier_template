import 'package:branvier/branvier.dart';
import 'package:branvier/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/theme/theme_service.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  ThemeService get theme => Modular.get();

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => MaterialApp.router(
        //Theme
        theme: theme.data,

        //Translation
        localizationsDelegates: Translation.delegates,

        //Routes
        // routerConfig: Modular.routerConfig,
        routerDelegate: Modular.routerDelegate,
        routeInformationParser: Modular.routeInformationParser,
      ),
    );
  }
}
