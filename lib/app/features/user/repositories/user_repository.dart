import '../models/user_model.dart';

abstract class UserRepository {
  /// Retorna o usuário logado.
  Future<UserModel> getUser();

  /// Atualiza o usuário logado.
  Future<void> updateUser(UserModel user);
}
