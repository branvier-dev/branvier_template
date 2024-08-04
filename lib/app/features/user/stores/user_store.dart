import 'package:flutter/foundation.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserStore extends ChangeNotifier {
  UserStore(this.repository);
  final UserRepository repository;

  late User _user = repository.cachedUser;

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
