import 'package:branvier/state.dart';

import '../../app_module.dart';
import '../main/main_controller.dart';

///Controls HomePage.
class HomeController {
  //States
  final _count = 1.obs;
  final _check = false.obs;

  //Getters
  int get count => _count.value;
  bool get isCheck => _check.value;

  //Events
  void onIncrement() => _count.value++;

  Future<void> onBoxCheck() async {
    _check.toggle(); //alternates between true & false
  }

  // ! verify if this is attached to the bind onDispose
  void onDispose() {
    // someService.disposeSomething();
  }
}
