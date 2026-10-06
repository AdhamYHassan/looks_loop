import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  const LogoutUseCase(this._repository);

  Future<ApiResult<void>> call() async {
    return await _repository.logout();
  }
}
