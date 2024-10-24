// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_async/flutter_async.dart';
import 'package:formx/formx.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../user/views/home_page.dart';
import '../models/register_dto.dart';
import '../stores/auth_store.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const name = 'register';
  static void go(BuildContext context) => context.goNamed(name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          constraints: const BoxConstraints(maxWidth: 360),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Register Page'),
                const Gap(80),
                TextFormField(
                  key: const Key('name'),
                  validator: Validator().required(),
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
                const Gap(16),
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
                  validator: Validator().required().minLength(6),
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    suffixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const Gap(32),
                FilledButton(
                  onPressed: () async {
                    final dto = RegisterDto.fromMap.of(context);
                    await context.read<AuthStore>().register(dto);

                    if (context.mounted) HomePage.go(context);
                  },
                  child: const Text('Cadastrar'),
                ).asAsync(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
