import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../auth/stores/auth_store.dart';
import '../../user/stores/user_store.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static const path = '/account';

  static const index = 1;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserStore>().user;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Account Page\n\n'),
            Text(user.name),
            Text(user.email),
            const Gap(100),
            OutlinedButton.icon(
              onPressed: () {
                context.read<AuthStore>().logout();
                context.go('/');
              },
              icon: const Icon(Icons.exit_to_app),
              label: const Text('SAIR'),
            ),
          ],
        ),
      ),
    );
  }
}
