import 'package:asp/asp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../shared/models/user.dart';
import '../../../../shared/repositories/user_repository.dart';

class UserService {
  UserService(this._repository);
  final UserRepository _repository;

  //States
  final _user = Atom<User>(Modular.args.data);

  /// Current [User].
  User get current => _user.value;

  /// Logout and clear cache.
  Future<void> logout() async {
    await _repository.logout();
  }
}
