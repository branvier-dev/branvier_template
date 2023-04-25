import 'package:flutter_modular/flutter_modular.dart';

import '_controller.dart';
import '_page.dart';

class MyModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => MyController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const MyPage()),
  ];
}
