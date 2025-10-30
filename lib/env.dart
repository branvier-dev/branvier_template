import 'package:flutter_async/flutter_async.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app/services/api/dio_service.dart';

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
    _ => 'v${info?.version} (${current.name})', // ex: v1.0.0 (staging)
  };

  /// [DioService.options] baseUrl.
  static String get apiUrl => String.fromEnvironment(
    'API_URL', // definida via --dart-define=API_URL
    defaultValue: switch (current) {
      production => 'https://api.branvierapps.com',
      _ => 'https://api-dev.branvierapps.com',
    },
  );
}
