import 'package:flutter/material.dart';

import '../../auth/widgets/logout_button.dart';

class UserShell extends StatelessWidget {
  const UserShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [LogoutButton()],
      ),
      body: child,
    );
  }
}
