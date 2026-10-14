import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_detail_entity.dart';

abstract class ProductDetailRepository {
  Future<ApiResult<ProductDetailEntity>> getProductDetail(String slug);
}
