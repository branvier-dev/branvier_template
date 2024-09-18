import 'package:branvier_template/app/app_injector.dart';
import 'package:branvier_template/app/features/auth/models/login_dto.dart';
import 'package:branvier_template/app/features/auth/stores/auth_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AuthStore', () async {
    final i = await AppInjector.setup(test: true);

    // You can use the DioMock class to mock the DioService.
    // i.replaceInstance<DioService>(DioMock());

    final store = AuthStore(i(), i());

    expect(store.isLogged, false);

    const dto = LoginDto(email: 'test@email.com', password: '123');
    await store.login(dto);

    expect(store.isLogged, true);
  });
}
