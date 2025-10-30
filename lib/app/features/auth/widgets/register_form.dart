import 'package:flutter/material.dart';
import 'package:flutter_async/flutter_async.dart';
import 'package:formx/formx.dart';
import 'package:provide_it/provide_it.dart';

import '../../user/views/home_page.dart';
import '../models/register_dto.dart';
import '../view_models/auth_notifier.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  static const _key = 'register_form';
  static Future<void> submit(BuildContext context) async {
    final map = context.submit(_key);
    final dto = RegisterDto.fromMap(map);

    await context.read<AuthStore>().register(dto);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: const Key(_key),
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Register Page'),
          TextFormField(
            key: const Key('name'),
            validator: Validator().required(),
            decoration: const InputDecoration(labelText: 'Nome'),
          ),
          TextFormField(
            key: const Key('email'),
            validator: Validator().required().email(),
            decoration: const InputDecoration(
              labelText: 'E-mail',
              suffixIcon: Icon(Icons.mail),
            ),
          ),
          TextFormField(
            key: const Key('password'),
            validator: Validator().required().minLength(6),
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Senha',
              suffixIcon: Icon(Icons.lock),
            ),
          ),
          const _RegisterButton(),
        ],
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        await RegisterForm.submit(context);

        if (context.mounted) HomePage.go(context);
      },
      child: const Text('Cadastrar'),
    ).asAsync();
  }
}
