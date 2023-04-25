import 'package:flutter_modular/flutter_modular.dart';
import 'auth_controller.dart';
import 'auth_page.dart';

///Binds [AuthController] to [AuthPage].
class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AuthController()),
  ];

  @override
  final List<ModularRoute> routes = [
    //You can also have separate login or signup here.
    ChildRoute('/', child: (_, args) => const AuthPage()),
  ];
}
