import 'package:flutter/material.dart';
import 'package:flutter_async/flutter_async.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserNotifier extends ChangeNotifier {
  UserNotifier(this.repository) {
    getUser();
  }
  final UserRepository repository;
  User? _user;

  User get user => _user ?? User.empty;

  Future<void> getUser() async {
    _user = await repository.getUser().showLoading().showSnackBar();
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    await repository.updateUser(user);
    await getUser();
  }
}
