import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() {

  // * Support methods
  Modular.setInitialRoute('/home/');

  // * Start
  return runApp(
    ModularApp(module: AppModule(), child: const RxRoot(child: AppWidget())),
  );
}
