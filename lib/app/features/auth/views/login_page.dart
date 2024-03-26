import 'package:flutter/material.dart';
import 'package:flutter_async/flutter_async.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../home/views/home_page.dart';
import '../models/login_dto.dart';
import '../stores/auth_store.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const path = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Text('Login Page'.toUpperCase()),
                        const Gap(80),
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
                        ),
                        // *
                        const Gap(8),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () =>
                                context.go(ForgotPasswordPage.path),
                            child: const Text('Recuperar senha'),
                          ),
                        ),

                        // *
                        const Gap(40),
                        FilledButton(
                          onPressed: () async {
                            if (!form.validate()) return;

                            final dto = LoginDto.fromMap(const {
                              'email': 'mock@email.com',
                              'password': '123',
                            });

                            await context.read<AuthStore>().login(dto);

                            if (context.mounted) context.go(HomePage.path);
                          },
                          child: const Text('Entrar'),
                        ).asAsync(),

                        const Gap(32),
                        // *
                        OutlinedButton(
                          onPressed: () => context.go(RegisterPage.path),
                          child: const Text('Cadastrar-se'),
                        ),
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
