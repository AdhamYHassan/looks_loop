import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_tokens_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_user_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/register_params.dart';
import 'package:looks_loop/features/auth/domain/repositories/auth_repository.dart';
import 'package:looks_loop/features/auth/domain/usecases/login_usecase.dart';
import 'package:looks_loop/features/auth/presentation/bloc/login_cubit.dart';
import 'package:looks_loop/features/auth/presentation/bloc/login_state.dart';

class MockAuthRepository implements AuthRepository {
  ApiResult<AuthResponseEntity> result;

  MockAuthRepository(this.result);

  @override
  Future<ApiResult<AuthResponseEntity>> login({
    required String phone,
    required String password,
    String? cartToken,
  }) async =>
      result;

  @override
  Future<ApiResult<AuthResponseEntity>> register(RegisterParams params) async =>
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
      access: 'access_jwt',
      refresh: 'refresh_jwt',
    ),
  );

  test('LoginCubit emits [LoginLoading, LoginSuccess] upon successful login', () async {
    final repo = MockAuthRepository(const ApiSuccess(dummyAuthResponse));
    final cubit = LoginCubit(LoginUseCase(repo));

    expectLater(
      cubit.stream,
      emitsInOrder([
        const LoginLoading(),
        const LoginSuccess(dummyAuthResponse),
      ]),
    );

    await cubit.login(phone: '+201007951864', password: 'SecretPassword');
  });

  test('LoginCubit emits [LoginLoading, LoginError] upon login failure', () async {
    final repo = MockAuthRepository(
      const ApiFailure(ServerFailure('Invalid phone or password')),
    );
    final cubit = LoginCubit(LoginUseCase(repo));

    expectLater(
      cubit.stream,
      emitsInOrder([
        const LoginLoading(),
        const LoginError('Invalid phone or password'),
      ]),
    );

    await cubit.login(phone: '+201007951864', password: 'WrongPassword');
  });
}
