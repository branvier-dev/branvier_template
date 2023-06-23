import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../user/home/home_page.dart';
import '../data/cart_repository.dart';

class CartService extends Reducer implements Disposable {
  // ignore: unused_field
  final CartRepository _repository;

  CartService(this._repository) {
    on(() => _items.value, () {
      if (_items.isEmpty) drawerKey.currentState?.closeEndDrawer();
    });
  }

  // * States
  final drawerKey = GlobalKey<ScaffoldState>();
  final _items = <Product>[].asAtom();

  /// All [Product]
  List<Product> get items => _items.toList();

  Future<void> openCart() async {
    drawerKey.currentState?.openEndDrawer();
  }

  void addProduct(Product product) {
    _items.add(product);
  }

  void removeProduct(Product product) {
    _items.remove(product);
  }

  void clearCart() {
    _items.clear();
  }

}
