import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../auth/auth_service.dart';
import '../../user_service.dart';

class DrawerWidget extends WidgetModule {
  const DrawerWidget({super.key});
  @override
  List<Bind> get binds => [
        AutoBind.lazySingleton(DrawerController.new),
      ];

  /// Get instance of [DrawerController].
  DrawerController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: controller.onLogout,
          ),
        ],
      ),
    );
  }
}

class DrawerController {
  //Denpendencies
  UserService get _user => Modular.get();

  //
  void onLogout() async {
    await _user.logout();
    Modular.to.navigate('/auth/login/');
  }
}
