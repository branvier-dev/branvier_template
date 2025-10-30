import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logarte/logarte.dart';
import 'package:provide_it/provide_it.dart';

import 'app_analytics.dart';
import 'features/auth/view_models/auth_notifier.dart';
import 'features/auth/views/forgot_password_page.dart';
import 'features/auth/views/initial_page.dart';
import 'features/auth/views/login_page.dart';
import 'features/auth/views/register_page.dart';
import 'features/user/view_models/user_notifier.dart';
import 'features/user/views/home_page.dart';
import 'features/user/views/user_shell.dart';

final goRouter = GoRouter(
  onEnter: _Route.onEnter,
  routes: [
    // Auth
    GoRoute(
      path: '/',
      redirect: (context, _) async {
        final isLogged = await context.read<AuthStore>().check();

        return isLogged ? '/home' : null;
      },
      name: InitialPage.name,
      builder: (_, _) => const InitialPage(),
      routes: [
        GoRoute(
          path: 'login',
          name: LoginPage.name,
          builder: (_, _) => const LoginPage(),
          routes: [
            GoRoute(
              path: 'forgot-password',
              name: ForgotPasswordPage.name,
              builder: (_, _) => const ForgotPasswordPage(),
            ),
          ],
        ),
        GoRoute(
          path: 'register',
          name: RegisterPage.name,
          builder: (_, _) => const RegisterPage(),
        ),
      ],
    ),

    // User
    ShellRoute(
      builder: (context, _, child) {
        context.provide(UserNotifier.new);

        return UserShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          name: HomePage.name,
          builder: (_, _) => const HomePage(),
        ),
      ],
    ),
  ],
);

class _Route extends Route {
  _Route(String? name) : super(settings: RouteSettings(name: name));

  static OnEnter get onEnter => (context, prev, next, router) {
    /// Enviamos logs de navegação pro Logarte.
    logarte.navigation(
      previousRoute: _Route(prev.name),
      route: _Route(next.name),
      action: NavigationAction.push,
    );
    return const Allow();
  };
}

extension BuildContextX on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<bool> showAlertDialog({
    required String title,
    required String content,
    String confirmText = 'OK',
  }) {
    return showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    ).then((v) => v ?? false);
  }
}
