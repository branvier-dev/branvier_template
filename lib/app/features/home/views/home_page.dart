import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../user/stores/user_store.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const path = '/home';

  static const index = 0;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserStore>().user;

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
