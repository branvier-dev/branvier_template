import 'package:flutter/material.dart';
import 'package:flutter_async/flutter_async.dart';
import 'package:formx/formx.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../user/views/home_page.dart';
import '../models/login_dto.dart';
import '../stores/auth_store.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const name = 'login';
  static void go(BuildContext context) => context.goNamed(name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          constraints: const BoxConstraints(maxWidth: 360),
          child: Form(
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
                FilledButton(
                  onPressed: () async {
                    final map = context.submit();
                    final dto = LoginDto.fromMap(map);
                    await context.read<AuthStore>().login(dto);

                    if (context.mounted) HomePage.go(context);
                  },
                  child: const Text('Entrar'),
                ).asAsync(),
                const Gap(32),
                OutlinedButton(
                  onPressed: () => RegisterPage.go(context),
                  child: const Text('Cadastrar-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
