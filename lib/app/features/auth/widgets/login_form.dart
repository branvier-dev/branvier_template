import 'package:flutter/material.dart';
import 'package:formx/formx.dart';

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
          LoginButton(
            getDto: () {
              final map = context.submit(key: key);

              return LoginDto.fromMap(map);
            },
          ),
          OutlinedButton(
            onPressed: () => RegisterPage.go(context),
            child: const Text('Cadastrar-se'),
          ),
        ],
      ),
    );
  }
}
