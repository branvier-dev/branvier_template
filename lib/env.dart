// ignore_for_file: avoid_print

/// Para rodar/buildar em [production], sete as variável de ambiente em `env.json`:
/// > `--dart-define-from-file=lib/env.json`
enum Env {
  development,
  staging,
  production;

  /// Inicializa o ambiente.
  static void init(Env env) {
    assert(_current == null, 'Env.current já foi inicializado.');
    print('${_current = env} init');
  }

  // O ambiente atual.
  static Env? _current;
  static Env get current => ArgumentError.checkNotNull(_current, 'Env.current');
  static bool get isDev => _current == development;

  // Váriaveis de ambiente.
  static const isProd = String.fromEnvironment('ENV') == 'production';
  static const apiUrl = String.fromEnvironment('API_URL', defaultValue: _sUrl);
}

/// Staging API URL.
const _sUrl = 'https://api-???.branvierapps.com';
