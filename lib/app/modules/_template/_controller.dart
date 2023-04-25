import 'package:branvier/state.dart';

class MyController {
  final count = 0.obs;

  void increment() => count.value++;
  void decrement() => count.value--;
  void onDispose() {}
}
