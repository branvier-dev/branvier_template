import 'package:branvier/branvier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'register_controller.dart';

///[RegisterPage] is a view controlled by [RegisterController].
class RegisterPage extends WidgetModule {
  const RegisterPage({super.key});

  @override
  List<Bind> get binds => [AutoBind.lazySingleton(RegisterController.new)];

  /// Get instance of [RegisterController].
  RegisterController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text(Modular.to.path)),
          body: Center(
            child: FormX.tr(
              controller: controller.formx,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Field.required('email'),
                    Field.required('password'),
                    const Divider(),
                    ElevatedButtonX(
                      hasFormx: true,
                      onPressed: controller.onRegister,
                      child: Text('register.onRegister'.tr),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
