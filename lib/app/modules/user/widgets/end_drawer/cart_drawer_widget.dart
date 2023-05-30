import 'package:branvier/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'cart_drawer_controller.dart';

class CartDrawerWidget extends WidgetModule {
  const CartDrawerWidget({super.key});

  @override
  List<Bind> get binds => [AutoBind.lazySingleton(CartDrawerController.new)];

  /// Get instance of [CartDrawerController].
  CartDrawerController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Shopping Cart'),
              Obx(
                () => Text(
                  'Total Price: \$${controller.totalPrice}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        body: Obx(
          () => ListView.builder(
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
                  onPressed: controller.onProceed,
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
