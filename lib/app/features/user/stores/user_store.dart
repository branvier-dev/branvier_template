import 'package:flutter/foundation.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserStore extends ChangeNotifier {
  UserStore(this.repository);

  final UserRepository repository;
  // ignore: unused_field
  late User _user = repository.cachedUser;

  User get user => const User(
        name: 'fake name',
        email: 'fake@email',
      );

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
