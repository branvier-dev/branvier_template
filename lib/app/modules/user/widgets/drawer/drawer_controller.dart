import 'package:flutter_modular/flutter_modular.dart';

import '../../user_service.dart';

class DrawerController {
  //Dependencies
  UserService get _user => Modular.get();

  /// Clear cache and leave.
  void onLogout() async {
    await _user.logout();
    Modular.to.navigate('/auth/login/');
  }
}
