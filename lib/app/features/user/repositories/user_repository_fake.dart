import '../models/user.dart';
import 'user_repository.dart';

class UserRepositoryFake implements UserRepository {
  var _user = const User(
    id: '42',
    name: 'Abraão Vieira',
    email: 'test@user.com',
  );

  @override
  Future<User> getUser() async {
    return _user;
  }

  @override
  Future<void> updateUser(User user) async {
    _user = user;
  }
}
