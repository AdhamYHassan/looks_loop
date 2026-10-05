import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/shop/domain/entities/category_detail_entity.dart';

abstract class CategoryDetailRepository {
  Future<ApiResult<CategoryDetailEntity>> getCategoryDetail(String audienceId);
}
