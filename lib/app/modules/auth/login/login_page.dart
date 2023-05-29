import 'package:branvier/branvier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_controller.dart';

///[LoginPage] is a view controlled by [LoginController].
class LoginPage extends WidgetModule {
  const LoginPage({super.key});

  @override
  List<Bind> get binds => [AutoBind.lazySingleton(LoginController.new)];

  /// Get instance of [LoginController].
  LoginController get controller => Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Modular.to.path)),
      body: Center(
        child: FormX(
          controller: controller.formx,
          onSubmit: controller.onLoginSubmit,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Field.required('email'),
                Field.required('password'),
                const Divider(),
                Row(
                  children: [
                    ElevatedButtonX(
                      onPressed: controller.onLoginTap,
                      child: Text('login.onLoginTap'.tr),
                    ),
                    ElevatedButton(
                      onPressed: controller.onRegisterTap,
                      child: Text('login.onRegisterTap'.tr),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

abstract class PageWidget extends Widget {
  Widget build(BuildContext context);
  List<Bind> get binds;

  const PageWidget({super.key});

  List<Module> get imports => const [];

  List<Bind> get exportedBinds => const [];

  @override
  Element createElement() => _ModuleElement(this);
}

class _ModuleImpl extends Module {
  @override
  final List<Bind> binds;
  @override
  final List<Bind> exportedBinds;
  @override
  final List<Module> imports;

  _ModuleImpl({
    this.binds = const [],
    this.exportedBinds = const [],
    this.imports = const [],
  });
}

class _ModuleElement extends ComponentElement {
  /// Creates an element that uses the given widget as its configuration.
  _ModuleElement(PageWidget super.widget);

  @override
  Widget build() {
    final widgetModule = widget as PageWidget;

    Widget child() => widgetModule.build(this);

    return _ModularProvider(
      module: _ModuleImpl(
        binds: widgetModule.binds,
        exportedBinds: widgetModule.exportedBinds,
        imports: widgetModule.imports,
      ),
      tag: widgetModule.runtimeType.toString(),
      child: child,
    );
  }

  @override
  void update(StatelessWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget, 'widget == newWidget');
    rebuild(force: true);
  }
}

class _ModularProvider extends StatefulWidget {
  final Widget Function() child;
  final Module module;
  final String tag;

  const _ModularProvider({
    super.key,
    required this.child,
    required this.module,
    required this.tag,
  });

  @override
  _ModularProviderState createState() => _ModularProviderState();
}

class _ModularProviderState extends State<_ModularProvider> {
  @override
  void initState() {
    super.initState();
    Modular.bindModule(widget.module);
    // injector.get<BindModule>().call(widget.module, widget.tag);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child();
  }

  @override
  void dispose() {
    super.dispose();
    Modular.unbindModule(type: widget.tag);
    // injector.get<UnbindModule>().call(type: widget.tag);
  }
}
