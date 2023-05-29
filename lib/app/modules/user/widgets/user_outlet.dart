import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'appbar/appbar_widget.dart';
import 'drawer/drawer_widget.dart';

///[UserOutlet] exposes all nested children.
class UserOutlet extends StatelessWidget {
  const UserOutlet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: RouterOutlet(),
    );
  }
}
