import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_tokens_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_user_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/register_params.dart';
import 'package:looks_loop/features/auth/domain/repositories/auth_repository.dart';
import 'package:looks_loop/features/auth/domain/usecases/register_usecase.dart';

class FakeAuthRepoForRegister implements AuthRepository {
  final ApiResult<AuthResponseEntity> registerResult;

  const FakeAuthRepoForRegister(this.registerResult);

  @override
  Future<ApiResult<AuthResponseEntity>> login({
    required String phone,
    required String password,
    String? cartToken,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<AuthResponseEntity>> register(RegisterParams params) async =>
      registerResult;

  @override
  Future<ApiResult<void>> logout() async => const ApiSuccess(null);
}

void main() {
  const dummyAuthResponse = AuthResponseEntity(
    user: AuthUserEntity(
      id: 10,
      phone: '+201001234567',
      phoneLocal: '01001234567',
      name: 'Ahmed Medhat',
      email: 'user@example.com',
      preferredLanguage: 'en',
    ),
    tokens: AuthTokensEntity(
      access: 'access_jwt',
      refresh: 'refresh_jwt',
    ),
  );

  test('RegisterUseCase executes repository register and returns ApiSuccess',
      () async {
    final repo = FakeAuthRepoForRegister(const ApiSuccess(dummyAuthResponse));
    final useCase = RegisterUseCase(repo);

    const params = RegisterParams(
      phone: '+201001234567',
      password: 'password123',
      name: 'Ahmed Medhat',
      email: 'user@example.com',
      gender: 'male',
      birthday: '2026-10-06',
    );

    final result = await useCase(params);

    expect(result, isA<ApiSuccess<AuthResponseEntity>>());
    expect((result as ApiSuccess<AuthResponseEntity>).data, dummyAuthResponse);
  });
}
