import 'package:branvier/branvier.dart';
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
    final fieldx = FieldController();

    postFrame(() {
      fieldx.text = Modular.to.path;
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Field('page', controller: fieldx),
            ElevatedButton(
              onPressed: () {
                Modular.to.pushNamed(fieldx.text);
              },
              child: Text('navigate'.tr),
            ),
            ElevatedButton(
              onPressed: Modular.to.maybePop, // * <- use canPop instead of pop
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
