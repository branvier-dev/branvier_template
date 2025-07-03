import 'package:flutter/material.dart';
import 'package:flutter_async/flutter_async.dart';
import 'package:formx/formx.dart';
import 'package:provide_it/provide_it.dart';

import '../../user/views/home_page.dart';
import '../models/login_dto.dart';
import '../view_models/auth_notifier.dart';
import '../views/forgot_password_page.dart';
import '../views/register_page.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  static const _key = 'login_form';
  static Future<void> submit(BuildContext context) async {
    final map = context.submit(_key);
    final dto = LoginDto.fromMap(map);

    await context.read<AuthNotifier>().login(dto);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: const Key(_key),
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Login Page'),
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
            validator: Validator()
                .required()
                .hasNumeric('Deve conter números')
                .minLength(6, 'Mínimo de 6 caracteres'),
            decoration: const InputDecoration(
              labelText: 'Senha',
              suffixIcon: Icon(Icons.lock),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () => ForgotPasswordPage.go(context),
              child: const Text('Recuperar senha'),
            ),
          ),
          const _LoginButton(),
          OutlinedButton(
            onPressed: () => RegisterPage.go(context),
            child: const Text('Cadastrar-se'),
          ),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        await LoginForm.submit(context);

        if (context.mounted) HomePage.go(context);
      },
      child: const Text('Entrar'),
    ).asAsync();
  }
}
