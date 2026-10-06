import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/register_params.dart';
import 'package:looks_loop/features/auth/domain/repositories/auth_repository.dart';

/// Single-responsibility interactor for creating a new user account.
class RegisterUseCase {
  final AuthRepository _repository;

  const RegisterUseCase(this._repository);

  Future<ApiResult<AuthResponseEntity>> call(RegisterParams params) {
    return _repository.register(params);
  }
}
