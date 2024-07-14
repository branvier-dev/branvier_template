import 'package:formx/formx.dart';

mixin AppAnalytics {
  static void logScreen({
    String? name,
    String? path,
    Map<String, String>? parameters,
  }) {
    // TODO(any): Implement the analytics screen.
    // _analytics.logScreenView(
    //   screenName: name?.screenName,
    //   screenClass: name?.className,
    //   parameters: {
    //     'path': path,
    //     ...?parameters,
    //   },
    // );
  }
}

enum AppClicks {
  authLogin;

  void log() {
    // TODO(any): Implement the analytics clicks.
    // _analytics.logEvent(
    //   name: 'button_click',
    //   parameters: {
    //     'button_name': name.snakeCase,
    //   },
    // );
  }
}

extension on String {
  // ignore: unused_element
  String get screenName => '${this}_screen';
  // ignore: unused_element
  String get className => '${pascalCase}Page';
}
