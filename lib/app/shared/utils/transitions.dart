import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin TransitionCustom {
  static CustomTransition get topLevel => CustomTransition(
        transitionBuilder: (context, anim1, anim2, child) {
          return const ZoomPageTransitionsBuilder()
              .buildTransitions(null, context, anim1, anim2, child);
        },
      );
  static CustomTransition get openUpwards => CustomTransition(
        transitionBuilder: (context, anim1, anim2, child) {
          return const OpenUpwardsPageTransitionsBuilder()
              .buildTransitions(null, context, anim1, anim2, child);
        },
      );
  static CustomTransition get fadeUpwards => CustomTransition(
        transitionBuilder: (context, anim1, anim2, child) {
          return const FadeUpwardsPageTransitionsBuilder()
              .buildTransitions(null, context, anim1, anim2, child);
        },
      );
  static CustomTransition cupertino(PageRoute route) => CustomTransition(
        transitionBuilder: (context, anim1, anim2, child) {
          return const CupertinoPageTransitionsBuilder()
              .buildTransitions(route, context, anim1, anim2, child);
        },
      );
}
