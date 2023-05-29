import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/data/source/hive_box.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Config
  await HiveBox.init();
  Modular.setInitialRoute('/home/');
  // Modular.init(AppModule());

  //Start
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
