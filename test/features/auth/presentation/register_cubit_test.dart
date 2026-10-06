import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_tokens_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_user_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/register_params.dart';
import 'package:looks_loop/features/auth/domain/repositories/auth_repository.dart';
import 'package:looks_loop/features/auth/domain/usecases/register_usecase.dart';
import 'package:looks_loop/features/auth/presentation/bloc/register_cubit.dart';
import 'package:looks_loop/features/auth/presentation/bloc/register_state.dart';

class MockAuthRepositoryForRegister implements AuthRepository {
  ApiResult<AuthResponseEntity> result;

  MockAuthRepositoryForRegister(this.result);

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
      result;

  @override
  Future<ApiResult<void>> logout() async => const ApiSuccess(null);
}

void main() {
  const dummyAuthResponse = AuthResponseEntity(
    user: AuthUserEntity(
      id: 5,
      phone: '+201001234567',
      phoneLocal: '01001234567',
      name: 'Ahmed Medhat',
      email: 'ahmed@test.com',
      preferredLanguage: 'en',
    ),
    tokens: AuthTokensEntity(
      access: 'jwt_access',
      refresh: 'jwt_refresh',
    ),
  );

  const testParams = RegisterParams(
    phone: '+201001234567',
    password: 'password123',
    name: 'Ahmed Medhat',
    email: 'ahmed@test.com',
  );

  test('RegisterCubit emits [RegisterLoading, RegisterSuccess] upon successful register',
      () async {
    final repo =
        MockAuthRepositoryForRegister(const ApiSuccess(dummyAuthResponse));
    final cubit = RegisterCubit(RegisterUseCase(repo));

    expectLater(
      cubit.stream,
      emitsInOrder([
        const RegisterLoading(),
        const RegisterSuccess(dummyAuthResponse),
      ]),
    );

    await cubit.register(testParams);
  });

  test('RegisterCubit emits [RegisterLoading, RegisterError] upon register failure',
      () async {
    final repo = MockAuthRepositoryForRegister(
      const ApiFailure(ServerFailure('Phone number already in use')),
    );
    final cubit = RegisterCubit(RegisterUseCase(repo));

    expectLater(
      cubit.stream,
      emitsInOrder([
        const RegisterLoading(),
        const RegisterError('Phone number already in use'),
      ]),
    );

    await cubit.register(testParams);
  });
}
