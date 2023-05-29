/// This class holds all your project environment variables.
///
/// You can set a launch.json configuration for custom behavior:
///
/// `{
///      "name": "my_project (custom)",
///      "request": "launch",
///      "type": "dart",
///      "flutterMode": "debug",
///      "args": [
///          "--dart-define=API_URL=my-api-url",
///      ]
///  },`
mixin Env {
  static const isLocal = mode == 'local';
  static const isStaging = mode == 'staging';
  static const isProduction = mode == 'production';

  /// Set with: `--dart-define=ENV=production`.
  static const mode = String.fromEnvironment('ENV', defaultValue: 'staging');

  /// Set with: `--dart-define=[VAR]=[VALUE]`.
  static const apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: _Local.apiUrl ?? _Staging.apiUrl ?? _Production.apiUrl ?? '',
  );
}

mixin _Local {
  /// The [apiUrl] hosted in a local server.
  static const apiUrl = Env.isLocal ? 'http://localhost:3348/v1' : null;
}

mixin _Staging {
  /// The [apiUrl] used for internal testing.
  /// ! "reqres" is an open source api ! Replace with yours.
  static const apiUrl = Env.isStaging ? 'https://reqres.in/api/' : null;
}

mixin _Production {
  /// The [apiUrl] used for official releases.
  static const apiUrl = Env.isProduction ? '' : null;
}
