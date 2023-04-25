import 'dart:async';

import 'package:branvier/branvier.dart';
import 'package:branvier/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_module.dart';
import 'services/app/theme_service.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  ThemeService get theme => Modular.get();

  @override
  Widget build(BuildContext context) {
    return AppLoader(
      load: Modular.isModuleReady<AppModule>,
      builder: (_) {
        return Obx(
          () => MaterialApp.router(
            //Theme
            theme: theme.data,

            //Translation
            key: Translation.key,
            localizationsDelegates: Translation.delegates,

            //Routes
            routeInformationParser: Modular.routeInformationParser,
            routerDelegate: Modular.routerDelegate,
          ),
        );
      },
    );
  }
}

class AppLoader extends StatelessWidget {
  const AppLoader({
    this.builder,
    this.load,
    this.loader = const Center(child: CircularProgressIndicator()),
    this.onLoaded,
    super.key,
  });

  final Future<void> Function()? load;
  final void Function()? onLoaded;
  final WidgetBuilder? builder;
  final Widget loader;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: load?.call(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return loader;
        WidgetsBinding.instance.addPostFrameCallback((_) => onLoaded?.call());
        return builder?.call(context) ?? const SizedBox.shrink();
      },
    );
  }
}
