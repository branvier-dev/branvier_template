import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';

///Controls CartPage.
class CartController extends Disposable {
  // * Dependencies
  // final CartService _cart = Modular.get();

  // * States
  final _count = Atom(1);

  // * Getters
  String get count => _count.value.toString();

  // * Events
  void onIncrement() => _count.value++;
  void onDecrement() => _count.value++;

  @override
  void dispose() {
    // _service
  }
}
