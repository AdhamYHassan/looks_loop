import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/more/domain/entities/app_info_entity.dart';
import 'package:looks_loop/features/more/domain/repositories/more_repository.dart';

class GetPolicyUseCase {
  final MoreRepository _repository;

  const GetPolicyUseCase(this._repository);

  Future<ApiResult<AppInfoEntity>> call() async {
    return await _repository.getPolicy();
  }
}

