/// Set with:
/// - `--dart-define-from-file=lib/env.json`
///
/// To build in production, ask for the deployers for the production `env.dart`.
mixin Env {
  static const apiUrl = String.fromEnvironment(
    'API_URL',
    // TODO(any): Set the staging base url.
    defaultValue: 'https://api-???.branvierapps.com',
  );

  static const encryptionKey = String.fromEnvironment(
    'ENCRYPTION_KEY',
    defaultValue: 'Debug-BEbbbNbMtIUE0r6CBo6dg1OuiU',
  );
}
