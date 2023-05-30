import 'package:branvier/state.dart';
import 'package:flutter/material.dart';

import '../../user/home/home_page.dart';
import '../data/cart_repository.dart';

/// [CartService] encapsulates all business logic of [CartItem].
class CartService {
  CartService(this._repository);
  final CartRepository _repository;

  // * States
  final drawerKey = GlobalKey<ScaffoldState>();
  final _items = <Product>[].obs;

  /// All [Product]
  List<Product> get items => _items.toList();

  bool get isNotEmpty => _items.isNotEmpty;

  Future<void> openCart() async {
    drawerKey.currentState?.openEndDrawer();
  }

  void addProduct(Product product) {
    _items.add(product);
  }

  void removeProduct(Product product) {
    _items.remove(product);
    if (items.isEmpty) drawerKey.currentState?.closeEndDrawer();
  }

  void clearCart() {
    _items.clear();
  }
}
