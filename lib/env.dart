import 'package:flutter_async/flutter_async.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app/services/api/dio_service.dart';

/// Para rodar/buildar em [production], sete as variável de ambiente em `env.json`:
/// > `--dart-define-from-file=lib/env.json`
enum Env {
  development,
  staging,
  production;

  /// O ambiente atual.
  static late Env current;

  static Future<void> init(Env env) async {
    current = env;
    info ??= await PackageInfo.fromPlatform().orNull();
  }

  static PackageInfo? info;
  static String get version => switch (current) {
    production => 'v${info?.version}',
    staging => 'v${info?.version} (staging)',
    development => 'v${info?.version} (development)',
  };

  /// [DioService.options] baseUrl.
  static String get apiUrl => switch (current) {
    production => 'https://api.branvierapps.com',
    _ => 'https://api-dev.branvierapps.com',
  };
}
