import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';

import '../../services/app/auth_service.dart';

class MainController extends ReassemblePath {
  //Denpendencies
  AuthService get _auth => Modular.get();

  //
  void onLogout() {
    _auth.logout();
    Modular.to.navigate('/auth/');
  }
}

///Use [ReassembleMixin] when you need to recover stack upon hot reload.
///
///Ex: [RouterOutlet] can't auto cache routes on reload.
class ReassemblePath with ReassembleMixin {
  late String path;
  late Completer completer;
  var count = 0;

  //Called every time the route changes. Stops when complete is called.
  void _reassemblePath() {
    //All paths in a list.
    final paths = path.split('/').where((e) => e.isNotEmpty).toList();
    final isLast = count == paths.length - 1;
    final slash = !isLast || path.endsWith('/') ? '/' : '';

    //Add to stack.
    Modular.to.pushNamed(Modular.to.path + paths[count++] + slash);

    //Completes after reading all.
    if (isLast) completer.complete();
  }

  @override
  void reassemble() async {
    count = 0;
    path = Modular.to.path; //current path
    completer = Completer(); //future starts

    Modular.to.addListener(_reassemblePath);
    await completer.future;
    Modular.to.removeListener(_reassemblePath);
  }
}
