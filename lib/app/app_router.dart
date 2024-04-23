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
import 'features/user/views/home_shell.dart';

mixin AppRouter {
  static final config = () {
    final i = AppInjector.instance;

    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          redirect: (context, _) {
            return context.read<AuthStore>().isLogged ? '/home' : '/login';
          },
        ),

        // * Auth
        GoRoute(
          path: '/login',
          name: LoginPage.name,
          builder: (_, __) => const LoginPage(),
          routes: [
            GoRoute(
              path: 'register',
              name: RegisterPage.name,
              builder: (_, __) => const RegisterPage(),
            ),
            GoRoute(
              path: 'forgot-password',
              name: ForgotPasswordPage.name,
              builder: (_, __) => const ForgotPasswordPage(),
            ),
          ],
        ),

        ShellRoute(
          builder: (_, __, child) => MultiProvider(
            providers: [
              StoreProvider(create: (_) => UserStore(i())),
            ],
            child: HomeShell(child: child),
          ),
          routes: [
            GoRoute(
              path: '/home',
              name: HomePage.name,
              builder: (_, __) => const HomePage(),
            ),
            GoRoute(
              path: '/account',
              name: AccountPage.name,
              builder: (_, __) => const AccountPage(),
              routes: [
                GoRoute(
                  path: 'edit',
                  name: EditAccountPage.name,
                  builder: (_, __) => const EditAccountPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }();
}
