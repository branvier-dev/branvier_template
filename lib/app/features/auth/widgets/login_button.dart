import 'package:flutter/material.dart';
import 'package:flutter_async/flutter_async.dart';
import 'package:provider/provider.dart';

import '../../user/views/home_page.dart';
import '../models/login_dto.dart';
import '../view_models/auth_view_model.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.getDto});
  final ValueGetter<LoginDto> getDto;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        final dto = getDto();
        await context.read<AuthViewModel>().login(dto);
        if (context.mounted) HomePage.go(context);
      },
      child: const Text('Entrar'),
    ).asAsync();
  }
}
