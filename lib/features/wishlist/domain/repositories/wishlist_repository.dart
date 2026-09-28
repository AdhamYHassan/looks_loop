import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';

abstract interface class WishlistRepository {
  Future<ApiResult<List<ProductEntity>>> getWishlist();
  Future<ApiResult<List<ProductEntity>>> removeFromWishlist(String productId);
}
