import 'package:flutter/foundation.dart';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserStore extends ChangeNotifier {
  UserStore(this.repository);
  final UserRepository repository;

  /// Como o [UserStore] é escopo das rotas logadas, ele jamais será nulo.
  UserModel get user => repository.user!;

  Future<void> updateUser(UserModel user) async {
    await repository.updateUser(user);
    notifyListeners();
  }
}
