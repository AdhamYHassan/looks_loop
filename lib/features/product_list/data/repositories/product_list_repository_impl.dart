import 'package:looks_loop/core/network/network_exceptions.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/product_list/data/datasources/product_list_remote_data_source.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';
import 'package:looks_loop/features/product_list/domain/repositories/product_list_repository.dart';

class ProductListRepositoryImpl implements ProductListRepository {
  final ProductListRemoteDataSource _remoteDataSource;

  const ProductListRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<ProductListEntity>> getProducts(
    GetProductsParams params,
  ) async {
    try {
      final model = await _remoteDataSource.getProducts(params);
      return ApiSuccess(model);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }
}
