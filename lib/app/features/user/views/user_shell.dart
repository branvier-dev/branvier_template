import 'package:flutter/material.dart';
import 'package:logarte/logarte.dart';
import 'package:provide_it/provide_it.dart';

import '../../../app_analytics.dart';
import '../../auth/widgets/logout_button.dart';
import '../view_models/user_notifier.dart';

class UserShell extends StatelessWidget {
  const UserShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserNotifier>().user;

    return Scaffold(
      appBar: AppBar(
        title: LogarteMagicalTap(logarte: logarte, child: Text(user.name)),
        actions: const [LogoutButton()],
      ),
      body: child,
    );
  }
}
