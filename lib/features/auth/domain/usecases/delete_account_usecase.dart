import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/auth/domain/repositories/auth_repository.dart';

class DeleteAccountUseCase {
  final AuthRepository _repository;

  const DeleteAccountUseCase(this._repository);

  Future<ApiResult<void>> call(String password) async {
    return await _repository.deleteAccount(password);
  }
}

