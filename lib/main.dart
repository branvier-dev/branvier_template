// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:go_provider/go_provider.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/app_injector.dart';
import 'app/app_setup.dart';
import 'app/features/auth/view_models/auth_view_model.dart';
import 'app/shared/widgets/app_error.dart';
import 'app/shared/widgets/app_splash.dart';
import 'env.dart';

void main(List<String> args) async {
  // Inicializamos o ambiente.
  Env.init(args);

  // Mostramos a splash enquanto carregamos as dependências.
  runApp(const AppSplash());

  try {
    // Inicializamos as dependências e configurações do app.
    await AppInjector.init();
    await AppSetup.init();

    runApp(
      MultiProvider(
        // Adicionamos estados globais aqui, acessíveis de qualquer lugar.
        providers: [
          ViewModelProvider(create: (i) => AuthViewModel(i())),
        ],
        child: const App(),
      ),
    );
  } catch (e, s) {
    // Se ocorrer um erro, mostramos uma tela de erro.
    runApp(AppError(error: e, stackTrace: s, onRetry: () => main(args)));
  }
}

/// Renomeamos para [ViewModelProvider] para consistência com os arquivos.
///
/// Use-o em rotas [GoProviderRoute] e acesse seu estado com `context.watch`.
typedef ViewModelProvider<T extends ChangeNotifier> = ChangeNotifierProvider<T>;
