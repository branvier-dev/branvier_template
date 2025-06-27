import 'package:go_router/go_router.dart';
import 'package:logarte/logarte.dart';
import 'package:provide_it/provide_it.dart';

import 'app_analytics.dart';
import 'features/auth/view_models/auth_store.dart';
import 'features/auth/views/forgot_password_page.dart';
import 'features/auth/views/initial_page.dart';
import 'features/auth/views/login_page.dart';
import 'features/auth/views/register_page.dart';
import 'features/user/view_models/user_notifier.dart';
import 'features/user/views/home_page.dart';
import 'features/user/views/user_shell.dart';

final goRouter = GoRouter(
  observers: _observers,
  routes: [
    GoRoute(
      /// Por padrão, o [GoRouter] tentará sempre acessar a rota '/'.
      /// Caso o usuário esteja logado, será redirecionado para a rota '/home'.
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
    ShellRoute(
      observers: _observers,
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
)..addAnalytics();

/// Adicionar no [GoRouter] e nos [ShellRoute] para logs.
final _observers = [LogarteNavigatorObserver(logarte)];

extension on GoRouter {
  void addAnalytics() {
    routerDelegate.addListener(() {
      // FirebaseAnalytics.instance.logScreenView(
      //   screenName: state.name,
      //   screenClass: state.name,
      //   parameters: {
      //     'path': state.fullPath,
      //     ...?state.pathParameters,
      //   },
      // );
    });
  }
}
