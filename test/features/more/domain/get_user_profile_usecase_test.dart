import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';
import 'package:looks_loop/features/more/domain/repositories/more_repository.dart';
import 'package:looks_loop/features/more/domain/usecases/get_user_profile_usecase.dart';

class FakeMoreRepository implements MoreRepository {
  final ApiResult<UserProfileEntity> result;

  const FakeMoreRepository(this.result);

  @override
  Future<ApiResult<UserProfileEntity>> getUserProfile() async => result;
}

void main() {
  test('GetUserProfileUseCase returns ApiSuccess when repository succeeds', () async {
    const dummyProfile = UserProfileEntity.guest();
    final repository = FakeMoreRepository(const ApiSuccess(dummyProfile));
    final useCase = GetUserProfileUseCase(repository);

    final result = await useCase();

    expect(result, isA<ApiSuccess<UserProfileEntity>>());
    expect((result as ApiSuccess<UserProfileEntity>).data, dummyProfile);
  });
}
