import 'package:flutter/material.dart';

// ignore: prefer_match_file_name
extension Scrollables on ScrollPosition {
  static var duration = const Duration(milliseconds: 600);
  static var curve = Curves.linearToEaseOut;
  static var clamp = true;

  void jump({double? to, double? by, bool? clamp}) {
    jumpTo(_value(to, by, clamp));
  }

  Future<void> animate({
    double? to,
    double? by,
    Duration? duration,
    Curve? curve,
    bool? clamp,
  }) {
    return animateTo(
      _value(to, by, clamp),
      duration: duration ?? Scrollables.duration,
      curve: curve ?? Scrollables.curve,
    );
  }

  double _value(double? to, double? by, bool? clamp) {
    var value = (to ?? pixels) + (by ?? 0);

    if (clamp ?? Scrollables.clamp) {
      value = value.clamp(minScrollExtent, maxScrollExtent);
    }

    return value;
  }
}

extension Scrollable2Extension on ScrollController {
  void jump({double? to, double? by, bool? clamp}) {
    jumpTo(position._value(to, by, clamp));
  }

  Future<void> animate({
    double? to,
    double? by,
    bool? clamp,
    Duration? duration,
    Curve? curve,
  }) {
    return animateTo(
      position._value(to, by, clamp),
      duration: duration ?? Scrollables.duration,
      curve: curve ?? Scrollables.curve,
    );
  }
}
