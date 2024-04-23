// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_async/flutter_async.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../home/views/home_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static const name = 'register';
  static void go(BuildContext context) => context.goNamed(name);

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Form(
                child: Builder(
                  builder: (context) {
                    final form = Form.of(context);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Register Page'.toUpperCase()),
                        const Gap(80),
                        // * Name
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Nome',
                          ),
                        ),
                        const Gap(16),
                        // * Email
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'E-mail',
                            suffixIcon: Icon(Icons.mail),
                          ),
                        ),
                        const Gap(16),
                        // * Password
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                            suffixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                        ),

                        // *
                        const Gap(32),
                        FilledButton(
                          onPressed: () async {
                            if (!form.validate()) return;
                            // final dto = RegisterUserDto.fromMap(state.form);
                            // await context.read<AuthStore>().registerUser(dto);

                            if (context.mounted) HomePage.go(context);
                          },
                          child: const Text('Cadastrar'),
                        ).asAsync(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
