import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'app_injector.dart';
import 'features/account/views/account_page.dart';
import 'features/account/views/edit_account_page.dart';
import 'features/auth/stores/auth_store.dart';
import 'features/auth/views/forgot_password_page.dart';
import 'features/auth/views/login_page.dart';
import 'features/auth/views/register_page.dart';
import 'features/home/views/home_page.dart';
import 'features/user/stores/user_store.dart';
import 'features/user/views/user_shell.dart';

mixin AppRouter {

  static final config = () {
    final i = AppInjector.instance;

    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          redirect: (context, _) {
            return context.read<AuthStore>().isLogged ? '/home' : null;
          },
          builder: (_, __) => const LoginPage(),
        ),

        // * Auth
        GoRoute(
          path: '/login',
          builder: (_, __) => const LoginPage(),
          routes: [
            GoRoute(
              path: 'register',
              builder: (_, __) => const RegisterPage(),
            ),
            GoRoute(
              path: 'forgot-password',
              builder: (_, __) => const ForgotPasswordPage(),
            ),
          ],
        ),

        // * User
        StatefulShellRoute.indexedStack(
          builder: (_, __, navigationShell) => MultiProvider(
            providers: [
              StoreProvider(create: (_) => UserStore(i())),
            ],
            child: UserShell(navigationShell: navigationShell),
          ),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/home',
                  builder: (_, __) => const HomePage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/account',
                  builder: (_, __) => const AccountPage(),
                  routes: [
                    GoRoute(
                      path: 'edit',
                      builder: (_, __) => const EditAccountPage(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }();
}
