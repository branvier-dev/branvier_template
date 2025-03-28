// ignore_for_file: lines_longer_than_80_chars, depend_on_referenced_packages

import 'package:flutter/widgets.dart';
import 'package:flutter_async/flutter_async.dart';
import 'package:formx/formx.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tr_extension/tr_extension.dart';

import '../env.dart';

extension AppSetup on BuildContext {
  static PackageInfo? info;
  static String get version =>
      'v${info?.version}${Env.isProd ? '' : ' (${Env.current.name})'}';

  static Future<void> init() async {
    // flutter_web_plugins

    // package_info_plus
    info = await PackageInfo.fromPlatform().orNull();

    // flutter_async
    Async.translator = (e) => switch (e) {
          ArgumentError(:String name) => 'form.invalid.$name'.tr,
          _ => Async.defaultMessage(e),
        };

    // formx
    Validator.translator = (key, errorText) => '$errorText.$key'.tr;
  }
}
