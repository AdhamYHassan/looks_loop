import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/shop/domain/entities/category_detail_entity.dart';
import 'package:looks_loop/features/shop/domain/repositories/category_detail_repository.dart';

class GetCategoryDetailUseCase {
  final CategoryDetailRepository _repository;

  const GetCategoryDetailUseCase(this._repository);

  Future<ApiResult<CategoryDetailEntity>> call(String audienceId) {
    return _repository.getCategoryDetail(audienceId);
  }
}
