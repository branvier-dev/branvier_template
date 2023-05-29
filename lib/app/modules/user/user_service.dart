import 'package:branvier/state.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'user.dart';
import 'user_repository.dart';

/// [UserService] encapsulates all business logic of [User].
class UserService {
  UserService(this._repository);
  final UserRepository _repository;
  //Services
  // OtherService get _otherService => Modular.get();

  //States
  final _user = (Modular.args.data as User).obs;

  /// Current [User].
  User get current => _user.value;

  //Async initializer
  void init() async {}

  /// Logout and clear cache.
  Future<void> logout() async {
    await _repository.logout();
  }
}
