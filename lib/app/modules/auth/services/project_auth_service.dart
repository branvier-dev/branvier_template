import 'package:branvier/branvier.dart';

import '../../user/user.dart';
import 'repositories/project_auth_repository.dart';

class ProjectAuthService {
  ProjectAuthService(this._repository);
  final ProjectAuthRepository _repository;

  /// Login and set token on cache.
  Future<User> login(Json map) {
    return _repository.login(map);
  }

  /// Register, set token and navigate to /home.
  Future<void> register(Json map) async {
    await _repository.register(map);
  }
}
