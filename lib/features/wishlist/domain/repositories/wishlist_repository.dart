import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';

abstract interface class WishlistRepository {
  Stream<List<ProductEntity>> get wishlistStream;

  Future<ApiResult<List<ProductEntity>>> getWishlist();
  Future<ApiResult<void>> addToWishlist(ProductEntity product);
  Future<ApiResult<void>> removeFromWishlist(String productId);
}
