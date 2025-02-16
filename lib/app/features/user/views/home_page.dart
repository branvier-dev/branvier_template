import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../view_models/user_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const name = 'home';
  static void go(BuildContext context) => context.goNamed(name);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserViewModel>().user;

    return Scaffold(
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
