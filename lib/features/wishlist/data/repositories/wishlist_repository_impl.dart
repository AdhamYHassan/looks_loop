import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:looks_loop/features/wishlist/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource _remoteDataSource;

  const WishlistRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<List<ProductEntity>>> getWishlist() async {
    try {
      final items = await _remoteDataSource.getWishlist();
      return ApiSuccess(items);
    } catch (e) {
      return ApiFailure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<ApiResult<List<ProductEntity>>> removeFromWishlist(
      String productId) async {
    try {
      final items = await _remoteDataSource.removeFromWishlist(productId);
      return ApiSuccess(items);
    } catch (e) {
      return ApiFailure(ServerFailure(e.toString()));
    }
  }
}
