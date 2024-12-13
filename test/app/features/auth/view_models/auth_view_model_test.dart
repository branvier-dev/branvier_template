import 'package:branvier_template/app/app_injector.dart';
import 'package:branvier_template/app/features/auth/models/login_dto.dart';
import 'package:branvier_template/app/features/auth/view_models/auth_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AuthViewModel', () async {
    final i = await AppInjector.init();

    // You can use the DioMock class to mock the DioService.
    // i.replaceInstance<DioService>(DioMock());

    final authVM = AuthViewModel(i());

    expect(authVM.isLogged, false);

    const dto = LoginDto(email: 'test@email.com', password: '123');
    await authVM.login(dto);

    expect(authVM.isLogged, true);
  });
}
