import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';
import 'package:looks_loop/features/auth/domain/repositories/auth_repository.dart';
import 'package:looks_loop/features/auth/domain/usecases/logout_usecase.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';
import 'package:looks_loop/features/more/domain/repositories/more_repository.dart';
import 'package:looks_loop/features/more/domain/usecases/get_user_profile_usecase.dart';
import 'package:looks_loop/features/more/presentation/bloc/more_cubit.dart';
import 'package:looks_loop/features/more/presentation/bloc/more_state.dart';

class MockMoreRepository implements MoreRepository {
  ApiResult<UserProfileEntity> result;

  MockMoreRepository(this.result);

  @override
  Future<ApiResult<UserProfileEntity>> getUserProfile() async => result;
}

class MockAuthRepository implements AuthRepository {
  @override
  Future<ApiResult<AuthResponseEntity>> login({
    required String phone,
    required String password,
    String? cartToken,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<void>> logout() async => const ApiSuccess(null);
}

void main() {
  const dummyProfile = UserProfileEntity.guest();

  test('MoreCubit emits [MoreLoading, MoreLoaded] upon successful profile fetch',
      () async {
    final repo = MockMoreRepository(const ApiSuccess(dummyProfile));
    final authRepo = MockAuthRepository();
    final cubit = MoreCubit(
      GetUserProfileUseCase(repo),
      LogoutUseCase(authRepo),
    );

    expectLater(
      cubit.stream,
      emitsInOrder([
        const MoreLoading(),
        const MoreLoaded(profile: dummyProfile),
      ]),
    );

    await cubit.loadUserProfile();
  });

  test('MoreCubit emits [MoreLoading, MoreError] upon profile fetch failure',
      () async {
    final repo =
        MockMoreRepository(const ApiFailure(UnknownFailure('Fetch failed')));
    final authRepo = MockAuthRepository();
    final cubit = MoreCubit(
      GetUserProfileUseCase(repo),
      LogoutUseCase(authRepo),
    );

    expectLater(
      cubit.stream,
      emitsInOrder([
        const MoreLoading(),
        const MoreError('Fetch failed'),
      ]),
    );

    await cubit.loadUserProfile();
  });

  test('MoreCubit.logout() emits [MoreLoading, MoreLoaded] after clearing session',
      () async {
    final repo = MockMoreRepository(const ApiSuccess(dummyProfile));
    final authRepo = MockAuthRepository();
    final cubit = MoreCubit(
      GetUserProfileUseCase(repo),
      LogoutUseCase(authRepo),
    );

    expectLater(
      cubit.stream,
      emitsInOrder([
        const MoreLoading(),
        const MoreLoaded(profile: dummyProfile),
      ]),
    );

    await cubit.logout();
  });
}
