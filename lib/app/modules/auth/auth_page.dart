import 'package:branvier/branvier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'auth_controller.dart';

///[AuthPage] is a view controlled by [AuthController].
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  /// Get instance of [AuthController].
  AuthController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Modular.to.path)),
      body: Center(
        child: FormX(
          controller: controller.formx,
          fieldWrapper: (tag, child) => child.pad(all: 8),
          decoration: (tag) {
            return InputDecoration(
              label: Text(tag.tr),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Field.required('email', controller: controller.emailx),
                Field.required('password', controller: controller.passwordx),
                const Divider(),
                ElevatedButtonX(
                  onPressed: controller.onLogin,
                  child: Text('auth.login'.tr),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
