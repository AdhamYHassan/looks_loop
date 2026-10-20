import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/featured_look_entity.dart';
import 'package:looks_loop/features/looks/domain/repositories/looks_repository.dart';

class GetLookDetailUseCase {
  final LooksRepository _repository;

  const GetLookDetailUseCase(this._repository);

  Future<ApiResult<FeaturedLookEntity>> call(String slug) {
    return _repository.getLookDetail(slug);
  }
}
