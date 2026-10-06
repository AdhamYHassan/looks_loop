import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_tokens_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_user_entity.dart';
import 'package:looks_loop/features/auth/domain/repositories/auth_repository.dart';
import 'package:looks_loop/features/auth/domain/usecases/login_usecase.dart';

class FakeAuthRepository implements AuthRepository {
  final ApiResult<AuthResponseEntity> result;

  const FakeAuthRepository(this.result);

  @override
  Future<ApiResult<AuthResponseEntity>> login({
    required String phone,
    required String password,
    String? cartToken,
  }) async =>
      result;

  @override
  Future<ApiResult<void>> logout() async => const ApiSuccess(null);
}

void main() {
  const dummyAuthResponse = AuthResponseEntity(
    user: AuthUserEntity(
      id: 2,
      phone: '+201007951864',
      phoneLocal: '01007951864',
      name: 'Adham',
      email: 'adham@gmail.com',
      preferredLanguage: 'en',
    ),
    tokens: AuthTokensEntity(
      access: 'dummy_access_token',
      refresh: 'dummy_refresh_token',
    ),
  );

  test('LoginUseCase returns ApiSuccess with AuthResponseEntity when repository succeeds', () async {
    final repository = FakeAuthRepository(const ApiSuccess(dummyAuthResponse));
    final useCase = LoginUseCase(repository);

    final result = await useCase(
      phone: '+201007951864',
      password: 'password123',
    );

    expect(result, isA<ApiSuccess<AuthResponseEntity>>());
    expect((result as ApiSuccess<AuthResponseEntity>).data, dummyAuthResponse);
  });
}
