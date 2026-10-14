import 'package:looks_loop/core/network/network_exceptions.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/product_detail/data/datasources/product_detail_remote_data_source.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:looks_loop/features/product_detail/domain/repositories/product_detail_repository.dart';

class ProductDetailRepositoryImpl implements ProductDetailRepository {
  final ProductDetailRemoteDataSource _remoteDataSource;

  const ProductDetailRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<ProductDetailEntity>> getProductDetail(String slug) async {
    try {
      final result = await _remoteDataSource.getProductDetail(slug);
      return ApiSuccess(result);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }
}
