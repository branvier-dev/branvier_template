import 'package:auto_injector/auto_injector.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../env.dart';
import '../main_development.dart';
import '../main_staging.dart';

extension AppInjector on BuildContext {
  @visibleForTesting
  static final i = AutoInjector();

  // Atalho para chamar os repositórios pelo `context`.
  // Ex: `context.call<AuthRepository>()` ou simplesmente `i()`.
  T call<T>() => i();

  /// Injeta as dependências de acordo com [env] e retorna [Locator].
  static Future<Locator> init({Env? env}) async {
    i.reset();

    await switch (env ?? Env.current) {
      Env.development => i.addFakes(),
      Env.staging => i.addImpls(test: true),
      Env.production => i.addImpls(test: false),
    };

    return i..commit();
  }
}

extension AutoInjectorX on AutoInjector {
  void reset() {
    dispose((i) {
      try {
        // ignore: avoid_dynamic_calls // Descarta todos as instâncias.
        i.dispose();
      } catch (_) {}
    });
  }
}
