import 'package:flutter/material.dart' hide DrawerController;
import 'package:flutter_modular/flutter_modular.dart';

import 'drawer_controller.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});
  
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
