import '../models/user_model.dart';
import 'user_repository.dart';

class UserRepositoryFake implements UserRepository {
  var _user = const UserModel(
    id: '42',
    name: 'Abraão Vieira',
    email: 'test@user.com',
  );

  @override
  Future<UserModel> getUser() async {
    return _user;
  }

  @override
  Future<void> updateUser(UserModel user) async {
    _user = user;
  }
}
