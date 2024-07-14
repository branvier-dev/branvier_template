import 'package:flutter/material.dart';

/// A widget that fades its child in and out based on the given [edges].
class Fade extends StatelessWidget {
  /// Creates a [Fade] widget.
  ///
  /// The [edges] values are applied to edges of the child. Greater values will
  /// result in a more pronounced fade effect in pixels.
  ///
  const Fade({
    super.key,
    this.edges = EdgeInsets.zero,
    required this.child,
  });
  final EdgeInsets edges;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const colors = [Colors.transparent, Colors.black];
    var child = this.child;

    if (edges.top > 0) {
      child = ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors,
            stops: [0.0, edges.top / bounds.height],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: child,
      );
    }

    if (edges.bottom > 0) {
      child = ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: colors,
            stops: [0.0, edges.bottom / bounds.height],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: child,
      );
    }

    if (edges.left > 0) {
      child = ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: colors,
            stops: [0.0, edges.left / bounds.width],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: child,
      );
    }

    if (edges.right > 0) {
      child = ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: colors,
            stops: [0.0, edges.right / bounds.width],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: child,
      );
    }

    return child;
  }
}
