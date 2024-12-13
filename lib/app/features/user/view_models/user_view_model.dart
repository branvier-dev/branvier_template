import 'package:flutter/material.dart';
import 'package:flutter_async/flutter_async.dart';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  UserViewModel(this.repository) {
    getUser();
  }
  final UserRepository repository;
  UserModel? _user;

  UserModel get user => _user ?? const UserModel();

  Future<void> getUser() async {
    _user = await repository.getUser().showLoading().showSnackBar();
    notifyListeners();
  }

  Future<void> updateUser(UserModel user) async {
    await repository.updateUser(user);
    await getUser();
  }
}
