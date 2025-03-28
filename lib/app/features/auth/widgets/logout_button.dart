import 'package:flutter/material.dart';
import 'package:provide_it/provide_it.dart';

import '../view_models/auth_store.dart';
import '../views/login_page.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        context.read<AuthStore>().logout();
        LoginPage.go(context);
      },
    );
  }
}
