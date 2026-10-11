import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/wishlist/domain/repositories/wishlist_repository.dart';

class WatchWishlistUseCase {
  final WishlistRepository _repository;

  const WatchWishlistUseCase(this._repository);

  Stream<List<ProductEntity>> call() => _repository.wishlistStream;
}
