import 'package:branvier_template/app/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    // * Sources
    // todo: implement

    // * Repositories
    // todo: implement

    // * Services
    // todo: implement
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/home', module: HomeModule()),
  ];
}
