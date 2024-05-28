import 'package:flutter/material.dart';
import 'package:go_provider/go_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'app_injector.dart';
import 'features/auth/stores/auth_store.dart';
import 'features/auth/views/forgot_password_page.dart';
import 'features/auth/views/initial_page.dart';
import 'features/auth/views/login_page.dart';
import 'features/auth/views/register_page.dart';
import 'features/home/views/home_page.dart';
import 'features/user/stores/user_store.dart';
import 'features/user/views/user_shell.dart';

extension AppRouter on GoRouter {
  @protected
  static Locator get i => AppInjector.instance;
  
  /// The [MaterialApp.routerConfig].
  static final config = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: InitialPage.name,
        builder: (_, __) => const InitialPage(),
        redirect: (c, __) => c.read<AuthStore>().isLogged ? '/home' : null,
        routes: [
          GoRoute(
            path: 'login',
            name: LoginPage.name,
            builder: (_, __) => const LoginPage(),
            routes: [
              GoRoute(
                path: 'forgot-password',
                name: ForgotPasswordPage.name,
                builder: (_, __) => const ForgotPasswordPage(),
              ),
            ],
          ),
          GoRoute(
            path: 'register',
            name: RegisterPage.name,
            builder: (_, __) => const RegisterPage(),
          ),
        ],
      ),
      ShellProviderRoute(
        providers: [
          StoreProvider(create: (_) => UserStore(i())),
        ],
        builder: (_, __, child) => UserShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: HomePage.name,
            builder: (_, __) => const HomePage(),
          ),
        ],
      ),
    ],
  );
}
