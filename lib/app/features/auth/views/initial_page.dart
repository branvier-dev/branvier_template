import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../app.dart';
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Initial Page'),
            const Gap(16),
            ElevatedButton(
              onPressed: () => LoginPage.go(context),
              child: const Text('Login'),
            ),
            const Gap(8),
            ElevatedButton(
              onPressed: () => RegisterPage.go(context),
              child: const Text('Register'),
            ),
            Text('App version: ${App.info.version}'),
          ],
        ),
      ),
    );
  }
}
