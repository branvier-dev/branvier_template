import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'main_controller.dart';

///[MainPage] is a view controlled by [MainController].
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  /// Get instance of [MainController].
  MainController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Modular.to.path)),
      drawer: Drawer(
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
      ),
      body: const RouterOutlet(),
    );
  }
}
