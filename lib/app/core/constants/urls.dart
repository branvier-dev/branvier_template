import 'package:flutter/foundation.dart';

/// ? what about flavors ?
///The Urls of the app. Responds dynamically.
mixin KUrls {
  ///The api's baseUrl.
  String get api => kDebugMode ? TestUrls.api : ProdUrls.api;
}

mixin TestUrls {
  static const api = 'my_test_url';
}

mixin ProdUrls {
  static const api = 'my_prod_url';
}
