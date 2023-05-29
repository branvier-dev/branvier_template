import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'temp_controller.dart';

class TempPage extends WidgetModule {
  const TempPage({super.key});

  @override
  List<Bind> get binds => [AutoBind.lazySingleton(TempController.new)];

  /// Get instance of [TempController].
  TempController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
