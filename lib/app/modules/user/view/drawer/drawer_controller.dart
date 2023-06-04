import 'package:flutter_modular/flutter_modular.dart';

import '../../data/services/user_service.dart';

class DrawerController {
  //Services
  UserService get _user => Modular.get();

  /// Clear cache and leave.
  void onLogoutTap() async {
    await _user.logout();
    Modular.to.navigate('/auth/login/');
  }
}
