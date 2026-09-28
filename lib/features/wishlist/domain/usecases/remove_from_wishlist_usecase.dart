import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/wishlist/domain/repositories/wishlist_repository.dart';

class RemoveFromWishlistUseCase {
  final WishlistRepository _repository;

  const RemoveFromWishlistUseCase(this._repository);

  Future<ApiResult<List<ProductEntity>>> call(String productId) {
    return _repository.removeFromWishlist(productId);
  }
}
