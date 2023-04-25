import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '_controller.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  /// Get instance of [MyController].
  MyController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                //todo: implement
              },
              child: Text('Welcome to ${Modular.to.path}'),
            ),
            ElevatedButton(
              onPressed: Modular.to.canPop,
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
