import 'package:flutter_modular/flutter_modular.dart';
import 'views/home/home_controller.dart';
import 'views/home/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    // * Controllers
    AutoBind.lazySingleton(HomeController.new),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HomePage()),
  ];
}
