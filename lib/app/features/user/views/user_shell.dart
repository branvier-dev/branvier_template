import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../account/views/account_page.dart';
import '../../home/views/home_page.dart';

class UserShell extends StatelessWidget {
  const UserShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  /// The paths that will show the bottom navigation bar.
  ///
  /// All other paths will animate the bottom navigation bar out.
  List<String> get navigationBarPaths => [
        AccountPage.path,
        HomePage.path,
      ];

  @override
  Widget build(BuildContext context) {
    /// Watches the current path. Just like `context.watch`
    final path = GoRouterState.of(context).fullPath;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AnimatedSize(
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
        child: Visibility(
          visible: navigationBarPaths.contains(path),
          child: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) => navigationShell.goBranch(
              index,
              initialLocation: navigationShell.currentIndex == index,
            ),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
            ],
          ),
        ),
      ),
    );
  }
}
