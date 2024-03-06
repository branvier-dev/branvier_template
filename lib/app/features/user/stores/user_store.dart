// ignore_for_file: prefer_declaring_const_constructors
import 'package:flutter/foundation.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserStore extends ChangeNotifier {
  UserStore(this.repository);

  final UserRepository repository;

  User get user {
    return repository.getUser();
  }

  Future<void> load() async {
    // TODO(Juan): implement load

    // _user = await Future(repository.getUser);
    // notifyListeners();
  }

  void setUser(User user) {
    // TODO(Juan): implement setUser
    // _user = user;
    // notifyListeners();
  }

  @override
  void dispose() {
    repository.clearUser();
    super.dispose();
  }
}
