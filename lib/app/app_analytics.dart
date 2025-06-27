import 'package:logarte/logarte.dart';

final logarte = Logarte();

extension LogarteExtension on Logarte {
  void click(String click) {
    log(click, source: 'button_click');
  }
}
