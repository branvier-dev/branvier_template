import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_controller.dart';

///[LoginPage] is a view controlled by [LoginController].
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  /// Get instance of [LoginController].
  LoginController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: controller.onLoginTap,
          child: const Text('Login'),
        ),
      ),
    );
  }
}
