import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/wishlist/domain/repositories/wishlist_repository.dart';

class AddToWishlistUseCase {
  final WishlistRepository _repository;

  const AddToWishlistUseCase(this._repository);

  Future<ApiResult<void>> call(ProductEntity product) {
    return _repository.addToWishlist(product);
  }
}
