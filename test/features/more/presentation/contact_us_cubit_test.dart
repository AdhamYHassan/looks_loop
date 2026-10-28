import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/domain/entities/app_info_entity.dart';
import 'package:looks_loop/features/more/domain/entities/contact_us_entity.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';
import 'package:looks_loop/features/more/domain/repositories/more_repository.dart';
import 'package:looks_loop/features/more/domain/usecases/get_contact_us_usecase.dart';
import 'package:looks_loop/features/more/presentation/bloc/contact_us_cubit.dart';
import 'package:looks_loop/features/more/presentation/bloc/contact_us_state.dart';

class StubContactUsRepository implements MoreRepository {
  final ApiResult<ContactUsEntity> result;

  StubContactUsRepository(this.result);

  @override
  Future<ApiResult<UserProfileEntity>> getUserProfile() async =>
      throw UnimplementedError();

  @override
  Future<ApiResult<AppInfoEntity>> getAboutUs() async =>
      throw UnimplementedError();

  @override
  Future<ApiResult<AppInfoEntity>> getPolicy() async =>
      throw UnimplementedError();

  @override
  Future<ApiResult<ContactUsEntity>> getContactUs() async => result;
}

void main() {
  test('ContactUsCubit emits Loading then Success', () async {
    const contact = ContactUsEntity(id: 1, mobile: '+966123456');
    final repo = StubContactUsRepository(const ApiSuccess(contact));
    final cubit = ContactUsCubit(GetContactUsUseCase(repo));

    final expectedStates = [
      const ContactUsLoading(),
      const ContactUsSuccess(contact),
    ];

    expectLater(cubit.stream, emitsInOrder(expectedStates));

    await cubit.fetchContactUs();
  });

  test('ContactUsCubit emits Loading then Error', () async {
    final repo =
        StubContactUsRepository(const ApiFailure(ServerFailure('Failed')));
    final cubit = ContactUsCubit(GetContactUsUseCase(repo));

    final expectedStates = [
      const ContactUsLoading(),
      const ContactUsError('Failed'),
    ];

    expectLater(cubit.stream, emitsInOrder(expectedStates));

    await cubit.fetchContactUs();
  });
}

