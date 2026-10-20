import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/looks/domain/entities/look_entity.dart';
import 'package:looks_loop/features/looks/domain/repositories/looks_repository.dart';

class GetLooksUseCase {
  final LooksRepository _repository;

  const GetLooksUseCase(this._repository);

  Future<ApiResult<List<LookSummaryEntity>>> call() {
    return _repository.getLooks();
  }
}
