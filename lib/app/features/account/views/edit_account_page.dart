import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../user/stores/user_store.dart';
import 'account_page.dart';

class EditAccountPage extends StatelessWidget {
  const EditAccountPage({super.key});

  static const name = 'edit-account';
  static void go(BuildContext context) => context.goNamed(name);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserStore>().user;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Edit Account Page\n\n'),
            Text(user.name),
            Text(user.email),
            const Gap(100),
            OutlinedButton.icon(
              onPressed: () {
                AccountPage.go(context);
              },
              icon: const Icon(Icons.exit_to_app),
              label: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
