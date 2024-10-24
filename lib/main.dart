// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/app_injector.dart';
import 'app/app_setup.dart';
import 'app/features/auth/stores/auth_store.dart';
import 'app/shared/widgets/app_error.dart';
import 'app/shared/widgets/app_splash.dart';

void main() async {
  try {
    // Mostramos a splash enquanto carregamos as dependências.
    runApp(const AppSplash());

    // Inicializamos as dependências do app.
    await AppInjector.init();

    // Inicializamos as configurações do app.
    await AppSetup.init();

    runApp(
      MultiProvider(
        /// Aqui é onde você adiciona as gerências de estado globais. Como elas
        /// estão acima do [App], elas podem ser acessadas de qualquer lugar.
        ///
        /// Consideramos globais aquelas que são públicas, podendo ser acessadas
        /// mesmo quando o usuário não está logado.
        ///
        /// Para todas as outras, você deve prover em um nível mais baixo, para
        /// isso, use o [StoreProvider] no `app_router.dart`.
        ///
        providers: [
          StoreProvider(create: (i) => AuthStore(i(), i())),
        ],
        child: const App(),
      ),
    );
  } catch (e, s) {
    // Mostramos o erro na tela caso ocorra um erro ao carregar o app.
    runApp(AppError(error: e, stackTrace: s, onRetry: main));
  }
}

/// Renomeamos o [ChangeNotifierProvider] para [StoreProvider] para manter a
/// consistência com o nome dos arquivos.
///
/// Usaremos o [StoreProvider] para prover as gerências de estado de cada rota.
/// Dessa forma, podemos controlar quais gerências de estado são acessíveis em
/// cada tela.
///
/// Após configurar o [StoreProvider] em cada rota, você pode acessar a gerência
/// de estado usando `context.watch` em qualquer widget filho.
///
typedef StoreProvider<T extends ChangeNotifier> = ChangeNotifierProvider<T>;
