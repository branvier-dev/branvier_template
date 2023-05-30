import 'package:flutter_modular/flutter_modular.dart';
import 'cart_controller.dart';
import 'cart_page.dart';

///Binds [CartController] to [CartPage].
class CartModule extends Module {
  @override
  final List<Bind> binds = [
    AutoBind.lazySingleton(CartController.new),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const CartPage()),
  ];
}
