import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:looks_loop/features/product_detail/domain/repositories/product_detail_repository.dart';

class GetProductDetailUseCase {
  final ProductDetailRepository _repository;

  const GetProductDetailUseCase(this._repository);

  Future<ApiResult<ProductDetailEntity>> call(String slug) {
    return _repository.getProductDetail(slug);
  }
}
