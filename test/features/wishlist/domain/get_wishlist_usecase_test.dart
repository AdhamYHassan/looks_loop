import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';

class FakeWishlistRepository implements WishlistRepository {
  final ApiResult<List<ProductEntity>> getResult;
  final ApiResult<List<ProductEntity>> removeResult;

  const FakeWishlistRepository({
    required this.getResult,
    required this.removeResult,
  });

  @override
  Future<ApiResult<List<ProductEntity>>> getWishlist() async => getResult;

  @override
  Future<ApiResult<List<ProductEntity>>> removeFromWishlist(
          String productId) async =>
      removeResult;
}

void main() {
  const dummyProduct = ProductEntity(
    id: 'w1',
    brand: 'MANGO',
    name: 'Wide Leg Trousers',
    price: 1590,
    imageUrl: 'https://example.com/item.jpg',
    isWishlisted: true,
  );

  test('GetWishlistUseCase returns ApiSuccess when repository succeeds', () async {
    const repository = FakeWishlistRepository(
      getResult: ApiSuccess([dummyProduct]),
      removeResult: ApiSuccess([]),
    );
    final useCase = GetWishlistUseCase(repository);

    final result = await useCase();

    expect(result, isA<ApiSuccess<List<ProductEntity>>>());
    expect((result as ApiSuccess<List<ProductEntity>>).data, [dummyProduct]);
  });

  test('RemoveFromWishlistUseCase returns updated list on success', () async {
    const repository = FakeWishlistRepository(
      getResult: ApiSuccess([dummyProduct]),
      removeResult: ApiSuccess([]),
    );
    final useCase = RemoveFromWishlistUseCase(repository);

    final result = await useCase('w1');

    expect(result, isA<ApiSuccess<List<ProductEntity>>>());
    expect((result as ApiSuccess<List<ProductEntity>>).data, isEmpty);
  });
}
