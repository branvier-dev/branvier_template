import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app_setup.dart';
import 'login_page.dart';
import 'register_page.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  static const name = 'initial';
  static void go(BuildContext context) => context.goNamed(name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Initial Page'),
            ElevatedButton(
              onPressed: () => LoginPage.go(context),
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () => RegisterPage.go(context),
              child: const Text('Register'),
            ),
            Text('App version: ${AppSetup.info?.version}'),
          ],
        ),
      ),
    );
  }
}
