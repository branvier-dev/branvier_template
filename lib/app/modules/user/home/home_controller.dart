import 'package:branvier/branvier.dart';
import 'package:branvier/state.dart';

///Controls HomePage.
class HomeController {
  //States
  final _count = 1.obs;
  final _check = false.obs;
  final formx = FormController();

  //Getters
  int get count => _count.value;
  bool get isCheck => _check.value;

  //Events
  void onIncrement() => _count.value++;

  Future<void> onBoxCheck() async {
    _check.toggle(); //alternates between true & false
  }

  // ! verify if this is attached to the AutoBind.singleton onDispose
  void onDispose() {
    // someService.disposeSomething();
  }
}
