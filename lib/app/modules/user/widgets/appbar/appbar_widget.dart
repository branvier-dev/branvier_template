import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppBarWidget extends WidgetModule implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  List<Bind> get binds => [];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(Modular.to.path),
    );
  }
}