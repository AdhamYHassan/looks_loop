import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';
import 'package:looks_loop/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  Future<ApiResult<AuthResponseEntity>> call({
    required String phone,
    required String password,
    String? cartToken,
  }) async {
    return await _repository.login(
      phone: phone,
      password: password,
      cartToken: cartToken,
    );
  }
}
