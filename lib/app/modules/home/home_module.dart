import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';
import 'home_page.dart';

///Binds [HomeController] to [ItemPage].
class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HomePage()),
    ChildRoute('/item', child: (context, args) => const ItemPage()),
  ];
}

///[ItemPage] is a view controlled by [HomeController].
class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  /// Get instance of [HomeController].
  HomeController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Modular.to.path)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                //todo: implement
              },
              child: const Text('Button Text'),
            ),
            ElevatedButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

extension ModularExtension on IModularNavigator {
  void back<T>([T? result]) {
    Modular.to.pop(result);
    print('object');
  }
}
