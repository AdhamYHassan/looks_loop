import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/domain/entities/app_info_entity.dart';
import 'package:looks_loop/features/more/domain/entities/contact_us_entity.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';
import 'package:looks_loop/features/more/domain/repositories/more_repository.dart';
import 'package:looks_loop/features/more/domain/usecases/get_about_us_usecase.dart';
import 'package:looks_loop/features/more/domain/usecases/get_contact_us_usecase.dart';
import 'package:looks_loop/features/more/domain/usecases/get_policy_usecase.dart';

class StubMoreRepository implements MoreRepository {
  final ApiResult<AppInfoEntity>? appInfoResult;
  final ApiResult<ContactUsEntity>? contactUsResult;

  const StubMoreRepository({
    this.appInfoResult,
    this.contactUsResult,
  });

  @override
  Future<ApiResult<UserProfileEntity>> getUserProfile() async =>
      throw UnimplementedError();

  @override
  Future<ApiResult<AppInfoEntity>> getAboutUs() async => appInfoResult!;

  @override
  Future<ApiResult<AppInfoEntity>> getPolicy() async => appInfoResult!;

  @override
  Future<ApiResult<ContactUsEntity>> getContactUs() async =>
      contactUsResult!;
}

void main() {
  test('GetAboutUsUseCase delegates to repository.getAboutUs', () async {
    const entity = AppInfoEntity(id: 1, title: 'About Us', content: 'Info');
    final repo = StubMoreRepository(appInfoResult: const ApiSuccess(entity));
    final useCase = GetAboutUsUseCase(repo);

    final result = await useCase();
    expect(result, isA<ApiSuccess<AppInfoEntity>>());
    expect((result as ApiSuccess<AppInfoEntity>).data, entity);
  });

  test('GetPolicyUseCase delegates to repository.getPolicy', () async {
    const entity = AppInfoEntity(id: 2, title: 'Policy', content: 'Policy Info');
    final repo = StubMoreRepository(appInfoResult: const ApiSuccess(entity));
    final useCase = GetPolicyUseCase(repo);

    final result = await useCase();
    expect(result, isA<ApiSuccess<AppInfoEntity>>());
    expect((result as ApiSuccess<AppInfoEntity>).data, entity);
  });

  test('GetContactUsUseCase delegates to repository.getContactUs', () async {
    const entity = ContactUsEntity(id: 1, mobile: '+966123456');
    final repo =
        StubMoreRepository(contactUsResult: const ApiSuccess(entity));
    final useCase = GetContactUsUseCase(repo);

    final result = await useCase();
    expect(result, isA<ApiSuccess<ContactUsEntity>>());
    expect((result as ApiSuccess<ContactUsEntity>).data, entity);
  });
}

