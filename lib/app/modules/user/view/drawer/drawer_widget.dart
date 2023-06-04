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
      child: Column(
        children: [
          const DrawerHeader(child: Text('Drawer')),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: controller.onLogoutTap,
          ),
        ],
      ),
    );
  }
}
