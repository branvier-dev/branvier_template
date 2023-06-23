import 'package:flutter_modular/flutter_modular.dart';

import '../../../cart/data/cart_service.dart';

class CartButtonController extends Disposable {
  //Services
  CartService get _cart => Modular.get();

  //States
  //

  //Getters
  //


  /// Opens the Cart.
  void onCartButton() {
    _cart.openCart();
  }

  @override
  void dispose() {}
}
