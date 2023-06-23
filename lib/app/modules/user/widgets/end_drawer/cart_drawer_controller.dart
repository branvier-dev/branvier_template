import 'package:dartx/dartx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../cart/data/cart_service.dart';
import '../../home/home_page.dart';

class CartDrawerController {
  CartService get _cart => Modular.get();

  List<Product> get items => _cart.items;

  /// Total price of the list.
  String get totalPrice => items.sumBy((e) => e.price).toStringAsFixed(2);

  /// Removes a [Product]
  void onRemoveProduct(Product product) {
    _cart.removeProduct(product);
  }

  void onProceed() {
    //payment
    
  }

  void onClearCart() {
    _cart.clearCart();
  }
}
