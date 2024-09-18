import 'package:flutter/material.dart';
import 'package:go_provider/go_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'app_analytics.dart';
import 'app_injector.dart';
import 'features/auth/stores/auth_store.dart';
import 'features/auth/views/forgot_password_page.dart';
import 'features/auth/views/initial_page.dart';
import 'features/auth/views/login_page.dart';
import 'features/auth/views/register_page.dart';
import 'features/user/stores/user_store.dart';
import 'features/user/views/home_page.dart';
import 'features/user/views/user_shell.dart';

extension AppRouter on GoRouter {
  /// Aqui é onde você define as rotas da aplicação, bem como os [StoreProvider]
  /// que devem ser providos para cada rota.
  ///
  /// Para atribuir um [StoreProvider] a uma rota, use [GoProviderRoute] em vez
  /// do [GoRoute].
  static final config = GoRouter(
    routes: [
      GoRoute(
        /// Por padrão, o [GoRouter] tentará sempre acessar a rota '/', mas caso o
        /// usuário esteja logado, ele será redirecionado para a rota '/home'.
        path: '/',
        redirect: (context, __) async {
          final isLogged = await context.read<AuthStore>().check();
          return isLogged ? '/home' : null;
        },
        name: InitialPage.name,
        builder: (_, __) => const InitialPage(),
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
        /// Aqui você pode adicionar as [StoreProvider] que podem ser acessados
        /// quando o usuário está logado.
        ///
        /// Evite adicionar muitos [StoreProvider] aqui, pois elas serão semi-
        /// globais. Prefira adicionar apenas as que são realmente acessadas em
        /// todas as telas do usuário.
        ///
        providers: [
          StoreProvider(create: (i) => UserStore(i())),
        ],

        /// O [UserShell] é um widget que envolve todas as telas do usuário.
        ///
        /// Use ele para adicionar elementos que devem ser exibidos em todas as
        /// telas do usuário, como a barra de navegação ou um menu lateral.
        ///
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
  )..addAnalytics();

  /// Acesso rápido as configurações da rota atual.
  RouteMatchList get current => routerDelegate.currentConfiguration;

  /// Conecta o [GoRouter] com o [AppAnalytics], para que ele possa escutar as
  /// mudanças de rota e enviar os eventos de navegação.
  void addAnalytics() {
    routerDelegate.addListener(() {
      AppAnalytics.logScreen(
        name: current.last.route.name,
        path: current.fullPath,
        parameters: current.pathParameters,
      );
    });
  }
}

extension AppRouterExtension on BuildContext {
  /// Acesso rápido as configurações da rota atual.
  ///
  /// Caso você precise reagir a mudanças de rota ou fazer uma gerência de
  /// estado, use o [GoRouterState.of]. Esse método irá automaticamente
  /// atualizar o widget quando a rota mudar, assim como o [watch] faz.
  ///
  RouteMatchList get route => GoRouter.of(this).current;

  /// Id do usuário logado.
  String? get userId => read<UserStore?>()?.user.id;

  // Adicione aqui ids de outras rotas/entitidades:
  //
  String? get exampleId => route.pathParameters['exampleId'];
}
