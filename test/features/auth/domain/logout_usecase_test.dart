import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';
import 'package:looks_loop/features/auth/domain/repositories/auth_repository.dart';
import 'package:looks_loop/features/auth/domain/usecases/logout_usecase.dart';

class FakeAuthRepoForLogout implements AuthRepository {
  final ApiResult<void> logoutResult;

  const FakeAuthRepoForLogout(this.logoutResult);

  @override
  Future<ApiResult<AuthResponseEntity>> login({
    required String phone,
    required String password,
    String? cartToken,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<void>> logout() async => logoutResult;
}

void main() {
  test('LogoutUseCase returns ApiSuccess on successful logout', () async {
    final repo = FakeAuthRepoForLogout(const ApiSuccess(null));
    final useCase = LogoutUseCase(repo);

    final result = await useCase();

    expect(result, isA<ApiSuccess<void>>());
  });
}
