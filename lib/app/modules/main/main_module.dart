import 'package:flutter_modular/flutter_modular.dart';
import '../home/home_module.dart';
import 'main_controller.dart';
import 'main_page.dart';

///Binds [MainController] to [MainPage].
class MainModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => MainController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const MainPage(),

      //Nested pages.
      children: [
        ModuleRoute('/home', module: HomeModule()),
      ],
    ),
  ];
}
