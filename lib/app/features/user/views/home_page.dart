import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provide_it/provide_it.dart';

import '../view_models/user_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const name = 'home';
  static void go(BuildContext context) => context.goNamed(name);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserViewModel>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('aaa'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Home Page \n\n'),
            const Text('Olá'),
            Text(user.name),
          ],
        ),
      ),
    );
  }
}
