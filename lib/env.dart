/// To build in production, set with:
/// - `--dart-define-from-file=lib/env.json`
///
mixin Env {
  static const apiUrl = String.fromEnvironment(
    'API_URL',
    // TODO(any): Set the staging base url.
    defaultValue: 'https://api-???.branvierapps.com',
  );
}
