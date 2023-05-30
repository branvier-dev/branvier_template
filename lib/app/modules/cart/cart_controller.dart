import 'package:flutter_modular/flutter_modular.dart';
import 'package:getx_lite/getx_lite.dart';

///Controls CartPage.
class CartController extends Disposable {
  // * Dependencies
  // final CartService _cart = Modular.get();

  // * States
  final _count = 1.obs;

  // * Getters
  String get count => _count.string;

  // * Events
  void onIncrement() => _count.value++;
  void onDecrement() => _count.value++;

  @override
  void dispose() {
    // _service
  }
}
