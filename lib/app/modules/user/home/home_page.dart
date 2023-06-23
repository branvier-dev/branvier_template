import 'package:branvier/branvier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/end_drawer/cart_drawer_widget.dart';
import 'home_controller.dart';

///[HomePage] is a view controlled by [HomeController].
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// Get instance of [HomeController].
  HomeController get controller => Modular.get();

  static BuildContext? context;

  @override
  Widget build(BuildContext context) {
    HomePage.context = context;
    return Scaffold(
      body: AsyncBuilder(
        future: controller.getProducts,
        builder: (products) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              var hovering = false;

              return StatefulBuilder(
                builder: (context, setState) {
                  return SuperHero(
                    onHover: (value) {
                      hovering = value;
                      if (!value) {
                        setState(() => hovering = value);
                      } else {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          if (hovering) setState(() => hovering = value);
                        });
                      }
                    },
                    builder: (context, value) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.easeInOut,
                        alignment: Alignment.centerRight,
                        width: (hovering || value > 0) ? 600 : 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 900),
                              curve: Curves.easeInOut,
                              height: 300,
                              width: (hovering || value > 0) ? 600 : 300,
                              child: Image.network(
                                'https://picsum.photos/200?random=${product.id}',
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRect(
                              child: Align(
                                heightFactor: value,
                                child: Container(
                                  height: 300,
                                  width: 600,
                                  color: Colors.white,
                                  child: Builder(
                                    builder: (context) {
                                      if (value != 1) return const SizedBox();
                                      return NewRouterOutlet(
                                        key: Key(index.toString()),
                                        path: '/home/',
                                        initial: '/home/dialog',
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ValueBuilder<T> extends StatefulWidget {
  const ValueBuilder({super.key, required this.value, required this.builder});

  final ValueNotifier<T> value;
  final Widget Function(ValueBuilderState<T> state, ValueNotifier<T> value)
      builder;

  @override
  State<ValueBuilder<T>> createState() => ValueBuilderState<T>();
}

class ValueBuilderState<T> extends State<ValueBuilder<T>> {
  @override
  void initState() {
    widget.value.addListener(notify);
    super.initState();
  }

  void notify() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.value.removeListener(notify);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(this, widget.value);
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final bool selected;
  final Function(Product product) onSelect;
  final Function(Product product) onUnselect;

  const ProductItem({
    required this.selected,
    required this.product,
    required this.onSelect,
    required this.onUnselect,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = 'https://picsum.photos/200?random=${product.id}';

    return InkWell(
      // onTap: () => !selected ? onSelect(product) : onUnselect(product),
      child: Card(
        color: selected ? Colors.green[100] : null,
        child: Column(
          children: [
            Image.network(imageUrl),
            const SizedBox(height: 8.0),
            Text(product.name),
            const SizedBox(height: 4.0),
            Text('\$${product.price.toStringAsFixed(2)}'),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final int id;
  final String name;
  final double price;

  Product(
    this.id,
    this.name,
    this.price,
  );
}

class SuperHero extends StatefulWidget {
  // Builder function that creates a widget based on the 'flying' state.
  final Widget Function(BuildContext context, double value) builder;

  /// The 'fly' animation duration.
  final Duration duration;
  final Curve scrollCurve;
  final Curve heroCurve;
  final Color barrierColor;
  final BorderRadius borderRadius;
  final void Function(double value)? onChange;
  final void Function(bool hovering)? onHover;
  final bool rootNavigator;

  const SuperHero({
    required this.builder,
    this.onChange,
    this.onHover,
    this.borderRadius = BorderRadius.zero,
    this.scrollCurve = Curves.fastOutSlowIn,
    this.heroCurve = Curves.easeOut,
    this.duration = const Duration(seconds: 1),
    this.barrierColor = Colors.black38,
    this.rootNavigator = false,
  });

  @override
  State<SuperHero> createState() => _SuperHeroState();
}

class _SuperHeroState extends State<SuperHero> {
  late final tag = widget.builder(context, 0).hashCode.toString();

  double setValue(double value) {
    widget.onChange?.call(value);
    return value;
  }

  var value = 0.0;

  var flying = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: widget.onHover,
      borderRadius: widget.borderRadius,
      onTap: () {
        flying = true;
        value = 0.0;
        Scrollable.ensureVisible(
          context,
          alignment: 0.5,
          duration: widget.duration,
          curve: widget.scrollCurve,
        );
        Navigator.of(context, rootNavigator: widget.rootNavigator)
            .push(
              PageRouteBuilder(
                opaque: false,
                transitionDuration: const Duration(seconds: 1),
                barrierDismissible: true,
                barrierColor: widget.barrierColor,
                pageBuilder: (_, animation, secondaryAnimation) {
                  return Center(
                    child: Hero(
                      tag: tag,
                      flightShuttleBuilder: (_, animation, __, ___, ____) {
                        return AnimatedBuilder(
                          animation: animation,
                          builder: (_, child) {
                            value = animation.value;
                            print('value: $value');

                            return widget.builder(
                              _,
                              setValue(value == 1 ? 0.999 : value),
                            );
                          },
                        );
                      },
                      createRectTween: (begin, end) {
                        return CurveRectTween(
                          begin: begin,
                          end: end,
                          curve: widget.heroCurve,
                        );
                      },
                      child: Builder(
                        builder: (context) {
                          return widget.builder(
                            context,
                            setValue(flying ? 1 : 0),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            )
            .then((value) => flying = false);
      },
      child: Hero(
        tag: tag,
        createRectTween: (begin, end) {
          return CurveRectTween(
            begin: begin,
            end: end,
            curve: widget.heroCurve,
          );
        },
        child: widget.builder(context, setValue(value)),
      ),
    );
  }
}

class CurveRectTween extends RectTween {
  final Curve curve;
  // final double arcEffect;

  CurveRectTween({
    required super.begin,
    required super.end,
    required this.curve,
    // this.arcEffect = 0.0,
  });

  @override
  Rect lerp(double t) {
    final easedT = curve.transform(t); // interpolation
    return super.lerp(easedT)!;

    // Calculate the arc offset
    // double directionX = (end!.center.dx - begin!.center.dx).sign;
    // double directionY = (end!.center.dy - begin!.center.dy).sign;

    // double offsetX = directionX * 0.5 * arcEffect * sin(easedT * pi);
    // double offsetY = directionY * 0.5 * arcEffect * sin(easedT * pi);

    // // Interpolate the rectangle's properties using the curved fraction,
    // // adjusted by the arc offset
    // return Rect.fromLTRB(
    //   lerpDouble(begin!.left, end!.left, easedT)! + offsetX,
    //   lerpDouble(begin!.top, end!.top, easedT)! + offsetY,
    //   lerpDouble(begin!.right, end!.right, easedT)! + offsetX,
    //   lerpDouble(begin!.bottom, end!.bottom, easedT)! + offsetY,
    // );
  }
}
