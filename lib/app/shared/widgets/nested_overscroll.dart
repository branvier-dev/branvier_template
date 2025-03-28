// ignore_for_file: type=lint
import 'package:flutter/widgets.dart';

/// A [NestedOverscroll] widget allows nested [Scrollable] widgets to overscroll
/// their parent [Scrollable].
class NestedOverscroll extends StatefulWidget {
  /// Creates a [NestedOverscroll] widget.
  ///
  /// - [physics] overrides the physics of all [Scrollable] nested widgets. It
  /// defaults to [ClampingScrollPhysics] to disable the overscroll effects.
  const NestedOverscroll({
    super.key,
    this.physics = const ClampingScrollPhysics(),
    required this.child,
  });
  final ScrollPhysics? physics;
  final Widget child;

  @override
  State<NestedOverscroll> createState() => _NestedOverscrollState();
}

class _NestedOverscrollState extends State<NestedOverscroll> {
  final _inscrolling = <int, bool>{};
  final _outscrolling = <int, bool>{};

  /// Whether any [ScrollableState.hashCode] is scrolling.
  bool get isScrolling =>
      _inscrolling.containsValue(true) || _outscrolling.containsValue(true);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        physics: widget.physics,
      ),
      child: NotificationListener(
        onNotification: (ScrollNotification sn) {
          final isMounted = sn.context?.mounted ?? false;
          if (!isMounted) return false;

          final scrollable = Scrollable.of(sn.context!);
          final parent = Scrollable.maybeOf(
            scrollable.context,
            axis: scrollable.widget.axis,
          );

          // if not nested or busy, ignore
          if (parent == null || isScrolling) return false;

          // touch scrolling
          if (sn is OverscrollNotification && sn.velocity == 0) {
            parent.position
                .jumpToClamped(parent.position.pixels + sn.overscroll);

            // inside inertia scrolling
          } else if (sn is OverscrollNotification) {
            _inscrolling[scrollable.hashCode] = true;

            parent.position
                .animateToClamped(parent.position.pixels + (sn.velocity / 5))
                .whenComplete(() => _inscrolling[scrollable.hashCode] = false);

            // outside inertia scrolling
          } else if (sn is ScrollEndNotification && sn.depth > 0) {
            _outscrolling[scrollable.hashCode] = true;

            final pps = sn.dragDetails?.velocity.pixelsPerSecond ?? Offset.zero;
            final velocity = pps.dx + pps.dy; // one is always zero

            parent.position
                .animateToClamped(parent.position.pixels - (velocity / 5))
                .whenComplete(() => _outscrolling[scrollable.hashCode] = false);
          }
          return true;
        },
        child: widget.child,
      ),
    );
  }
}

extension on ScrollPosition {
  void jumpToClamped(double value) {
    jumpTo(value.clamp(minScrollExtent, maxScrollExtent));
  }

  Future<void> animateToClamped(double value) {
    return animateTo(
      value.clamp(minScrollExtent, maxScrollExtent),
      duration: const Duration(milliseconds: 600),
      curve: Curves.linearToEaseOut,
    );
  }
}
