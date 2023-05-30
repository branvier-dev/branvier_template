
import 'package:branvier/branvier.dart';
import 'package:branvier/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';

///[HomePage] is a view controlled by [HomeController].
class HomePage extends WidgetModule {
  const HomePage({super.key});

  @override
  List<Bind> get binds => [AutoBind.singleton(HomeController.new)];

  /// Get instance of [HomeController].
  HomeController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AsyncBuilder(
        future: controller.getProducts,
        builder: (products) {
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: switch (context.width) {
                > 1400 => 5,
                > 1200 => 4,
                > 900 => 3,
                > 600 => 2,
                _ => 1,
              },
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Obx(
                () => ProductItem(
                  product: product,
                  selected: controller.items.contains(product),
                  onSelect: controller.onItemSelect,
                  onUnselect: controller.onItemUnselect,
                ),
              );
            },
          );
        },
      ),
    );
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
      onTap: () => !selected ? onSelect(product) : onUnselect(product),
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
