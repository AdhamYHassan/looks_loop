import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';
import 'package:looks_loop/features/product_list/domain/repositories/product_list_repository.dart';

class GetProductsUseCase {
  final ProductListRepository _repository;

  const GetProductsUseCase(this._repository);

  Future<ApiResult<ProductListEntity>> call(GetProductsParams params) {
    return _repository.getProducts(params);
  }
}
