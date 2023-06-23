import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../cart/data/cart_service.dart';
import 'home_page.dart';

///Controls HomePage.
class HomeController {
  //States
  CartService get _cart => Modular.get();

  List<Product> get items => _cart.items;

  Future<List<Product>> getProducts() async {
    await 2.seconds.delay;


    return List.generate(18, (index) {
      return Product(index, 'Product $index', Random().nextDouble() * 25);
    });
  }

  void onItemSelect(Product product) {
    _cart.addProduct(product);
  }

  void onItemUnselect(Product product) {
    _cart.removeProduct(product);
  }
}
