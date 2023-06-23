// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:asp/asp.dart';
// import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'cart_drawer_controller.dart';

class CartDrawerWidget extends StatelessWidget {
  const CartDrawerWidget({super.key});

  /// Get instance of [CartDrawerController].
  CartDrawerController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    // return RouterOutlet();

    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Shopping Cart'),
              RxBuilder(
                builder: (_) {
                  return Text(
                    'Total Price: \$${controller.totalPrice}',
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ],
          ),
        ),
        body: RxBuilder(
          builder: (_) => ListView.builder(
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              final product = controller.items[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () => controller.onRemoveProduct(product),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: controller.onClearCart,
                  child: const Text('Clear Cart'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Modular.to.navigate('/home/dialog');

                    showDialog(
                      context: context,
                      routeSettings: ModalRoute.of(context)?.settings,
                      useRootNavigator: false,
                      builder: (_) {
                        return const AlertDialog(
                          content: NewRouterOutlet(
                            path: '/home/dialog',
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Proceed'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContextBuilder extends StatelessWidget {
  const ContextBuilder({
    super.key,
    required this.context,
    required this.builder,
  });

  final BuildContext context;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return builder(this.context);
  }
}

/// It acts as a Nested Browser that will be populated
/// by the children of this route.
class NewRouterOutlet extends StatefulWidget {
  /// An interface for observing the behavior of a [Navigator].
  final List<NavigatorObserver>? observers;
  final String? path;
  final String? initial;

  /// It acts as a Nested Browser that will be populated
  /// by the children of this route.
  const NewRouterOutlet({super.key, this.observers, this.path, this.initial});

  @override
  NewRouterOutletState createState() => NewRouterOutletState();
}

class NewRouterOutletState extends State<NewRouterOutlet> {
  late GlobalKey<NavigatorState> _navigatorKey;
  RouterOutletDelegate? _delegate;
  late ChildBackButtonDispatcher _backButtonDispatcher;

  /// Get all current observers
  List<NavigatorObserver> get currentObservers =>
      widget.observers ?? <NavigatorObserver>[];

  @override
  void initState() {
    super.initState();

    print('intiState');

    // Modular.to.navigate(widget.path ?? '/home');
    _navigatorKey = GlobalKey<NavigatorState>();
    if (widget.initial != null) Modular.to.navigate(widget.initial!);
    Modular.to.addListener(listener);
  }

  /// visible for test
  @visibleForTesting
  void listener() {
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // final modal = ModalRoute.of(context)?.settings as dynamic;
    // if (modal == null) {
    //   return;
    // }
    _delegate ??= RouterOutletDelegate(
      widget.path ?? Modular.to.path,
      Modular.routerDelegate,
      _navigatorKey,
      currentObservers,
    );
    final router = Router.of(context);
    _backButtonDispatcher =
        router.backButtonDispatcher!.createChildBackButtonDispatcher();
  }

  @override
  void dispose() {
    super.dispose();
    Modular.to.removeListener(listener);
    if (widget.path != null) Modular.to.navigate(widget.path!);
  }

  @override
  Widget build(BuildContext context) {
    _backButtonDispatcher.takePriority();
    return Router(
      routerDelegate: _delegate!,
      backButtonDispatcher: _backButtonDispatcher,
    );
  }
}

class RouterOutletDelegate extends RouterDelegate<ParallelRoute>
    with
        // ignore: prefer_mixin
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<ParallelRoute> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final modularRouterDelegate;
  final String path;
  final List<NavigatorObserver>? observers;

  RouterOutletDelegate(
    this.path,
    this.modularRouterDelegate,
    this.navigatorKey,
    this.observers,
  );

  List<Page> _getPages() {
    return modularRouterDelegate.currentConfiguration
            ?.chapters(path)
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    final pages = _getPages();
    return pages.isEmpty
        ? const Material()
        : CustomNavigator(
            key: navigatorKey,
            modularBase: Modular,
            pages: pages,
            observers: observers ?? [],
            onPopPage: modularRouterDelegate.onPopPage,
          );
  }

  @override
  Future<void> setNewRoutePath(ParallelRoute configuration) async {
    assert(false, 'Dont use this');
  }
}

class CustomNavigator extends Navigator {
  final modularBase;

  const CustomNavigator({
    super.key,
    required this.modularBase,
    super.observers,
    super.pages,
    super.onPopPage,
  });

  @override
  // ignore: no_logic_in_create_state
  NavigatorState createState() => _CustomNavigatorState(modularBase);
}

class _CustomNavigatorState extends NavigatorState {
  final modularBase;

  _CustomNavigatorState(this.modularBase);

  @override
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return modularBase.to.pushNamed<T>(routeName, arguments: arguments);
  }

  @override
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return modularBase.to.popAndPushNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  @override
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    predicate, {
    Object? arguments,
  }) {
    return modularBase.to.pushNamedAndRemoveUntil<T>(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  @override
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return modularBase.to.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }
}
