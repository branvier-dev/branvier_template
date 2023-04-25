import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  //Config
  Modular.setNavigatorKey(App.key);
  Modular.setInitialRoute('/home/');

  //Start
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

mixin App {
  static final key = GlobalKey<NavigatorState>();
}
