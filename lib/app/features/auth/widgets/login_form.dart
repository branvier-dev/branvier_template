import 'package:flutter/material.dart';
import 'package:formx/formx.dart';
import 'package:gap/gap.dart';

import '../models/login_dto.dart';
import '../views/forgot_password_page.dart';
import '../views/register_page.dart';
import 'login_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    const key = 'login_form';

    return Form(
      key: const Key(key),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Login Page'),
          const Gap(80),
          TextFormField(
            key: const Key('email'),
            validator: Validator().required().email(),
            decoration: const InputDecoration(
              labelText: 'E-mail',
              suffixIcon: Icon(Icons.mail),
            ),
          ),
          const Gap(16),
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
          // *
          const Gap(8),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () => ForgotPasswordPage.go(context),
              child: const Text('Recuperar senha'),
            ),
          ),
          const Gap(40),
          LoginButton(
            getDto: () {
              final map = context.submit(key: key);
              return LoginDto.fromMap(map);
            },
          ),
          const Gap(32),
          OutlinedButton(
            onPressed: () => RegisterPage.go(context),
            child: const Text('Cadastrar-se'),
          ),
        ],
      ),
    );
  }
}
