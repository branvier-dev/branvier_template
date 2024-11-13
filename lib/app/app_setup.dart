// ignore_for_file: lines_longer_than_80_chars, depend_on_referenced_packages

import 'package:flutter/widgets.dart';
import 'package:flutter_async/flutter_async.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:formx/formx.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tr_extension/tr_extension.dart';

extension AppSetup on BuildContext {
  static PackageInfo? info;

  static Future<void> init() async {
    // flutter_web_plugins
    usePathUrlStrategy();

    // package_info_plus
    info = await PackageInfo.fromPlatform().orNull();

    // flutter_async
    Async.translator = (e) => switch (e) {
          ArgumentError(:String name) => 'form.invalid.$name'.tr,
          _ => Async.defaultMessage(e),
        };

    // formx
    Validator.translator = (key, errorText) => '$errorText.$key'.tr;
    // Formx.setup = FormxSetup(
    // imageDeleter: (url) => FirebaseStorage.instance.refFromURL(url).delete(),
    // imageUploader: (file, path) async => FirebaseStorage.instance
    //     .ref(path)
    //     .putString(await file.readAsString())
    //     .then((e) => e.ref.getDownloadURL()),
    // );
  }
}
