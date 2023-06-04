import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/shared/sources/hive_box.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Config
  await HiveBox.init();
  Modular.setInitialRoute('/home/');

  //Start
  return runApp(
    ModularApp(module: AppModule(), child: RxRoot(child: const AppWidget())),
  );
}
