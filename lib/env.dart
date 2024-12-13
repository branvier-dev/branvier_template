// ignore_for_file: avoid_print

/// Para rodar/buildar em [production], sete as variável de ambiente em `env.json`:
/// > `--dart-define-from-file=lib/env.json`
enum Env {
  /// Repositories locais, sem services.
  development,

  /// Repositories remotos, services fakes.
  staging,

  /// Repositories remotos e services reais.
  production;

  /// Inicializa o ambiente.
  static void init(List<String> args) {
    _current = switch (args) {
      _ when isProd => production,
      ['staging'] => staging,
      _ => development,
    };
    print('Env.init: ${current.name}');
  }

  // O ambiente atual.
  static Env _current = development;
  static Env get current => _current;
  static bool get isDev => current == development;

  // Váriaveis de ambiente.
  static const isProd = String.fromEnvironment('ENV') == 'production';
  static const apiUrl = String.fromEnvironment('API_URL', defaultValue: _sUrl);
}

/// Staging API URL.
const _sUrl = 'https://api-???.branvierapps.com';
