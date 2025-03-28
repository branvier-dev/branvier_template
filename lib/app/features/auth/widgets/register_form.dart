import 'package:flutter/material.dart';
import 'package:formx/formx.dart';

import '../models/register_dto.dart';
import 'register_button.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    const key = 'register_form';

    return Form(
      key: const Key(key),
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Register Page'),
          TextFormField(
            key: const Key('name'),
            validator: Validator().required(),
            decoration: const InputDecoration(
              labelText: 'Nome',
            ),
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
          RegisterButton(
            getDto: () {
              final map = context.submit(key: key);

              return RegisterDto.fromMap(map);
            },
          ),
        ],
      ),
    );
  }
}
