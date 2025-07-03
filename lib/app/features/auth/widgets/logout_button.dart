import 'package:flutter/material.dart';
import 'package:flutter_async/flutter_async.dart';
import 'package:provide_it/provide_it.dart';

import '../view_models/auth_notifier.dart';
import '../views/login_page.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () async {
        await context.read<AuthNotifier>().logout();
        if (context.mounted) LoginPage.go(context);
      },
    ).asAsync();
  }
}
