// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_async/flutter_async.dart';
import 'package:provider/provider.dart';

import '../../user/views/home_page.dart';
import '../models/register_dto.dart';
import '../view_models/auth_view_model.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key, required this.getDto});
  final ValueGetter<RegisterDto> getDto;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        final dto = getDto();
        await context.read<AuthViewModel>().register(dto);

        if (context.mounted) HomePage.go(context);
      },
      child: const Text('Cadastrar'),
    ).asAsync();
  }
}
