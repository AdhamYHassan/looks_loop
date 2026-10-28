import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/domain/entities/app_info_entity.dart';
import 'package:looks_loop/features/more/domain/entities/contact_us_entity.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';
import 'package:looks_loop/features/more/domain/repositories/more_repository.dart';
import 'package:looks_loop/features/more/domain/usecases/get_about_us_usecase.dart';
import 'package:looks_loop/features/more/domain/usecases/get_policy_usecase.dart';
import 'package:looks_loop/features/more/presentation/bloc/app_info_cubit.dart';
import 'package:looks_loop/features/more/presentation/bloc/app_info_state.dart';

class MockMoreRepository implements MoreRepository {
  final ApiResult<AppInfoEntity> result;

  MockMoreRepository(this.result);

  @override
  Future<ApiResult<UserProfileEntity>> getUserProfile() async =>
      throw UnimplementedError();

  @override
  Future<ApiResult<AppInfoEntity>> getAboutUs() async => result;

  @override
  Future<ApiResult<AppInfoEntity>> getPolicy() async => result;

  @override
  Future<ApiResult<ContactUsEntity>> getContactUs() async =>
      throw UnimplementedError();
}

void main() {
  test('AppInfoCubit emits Loading then Loaded on success', () async {
    const info = AppInfoEntity(id: 1, title: 'About', content: 'Content');
    final repo = MockMoreRepository(const ApiSuccess(info));
    final cubit = AppInfoCubit(
      GetAboutUsUseCase(repo),
      GetPolicyUseCase(repo),
    );

    final expectedStates = [
      const AppInfoLoading(),
      const AppInfoLoaded(info),
    ];

    expectLater(cubit.stream, emitsInOrder(expectedStates));

    await cubit.loadInfo(AppInfoType.aboutUs);
  });

  test('AppInfoCubit emits Loading then Error on failure', () async {
    final repo = MockMoreRepository(const ApiFailure(ServerFailure('Server error')));
    final cubit = AppInfoCubit(
      GetAboutUsUseCase(repo),
      GetPolicyUseCase(repo),
    );

    final expectedStates = [
      const AppInfoLoading(),
      const AppInfoError('Server error'),
    ];

    expectLater(cubit.stream, emitsInOrder(expectedStates));

    await cubit.loadInfo(AppInfoType.policy);
  });
}

