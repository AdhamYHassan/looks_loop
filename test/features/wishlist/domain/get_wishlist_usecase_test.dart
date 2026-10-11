import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';

class FakeWishlistRepository implements WishlistRepository {
  final ApiResult<List<ProductEntity>> getResult;
  final ApiResult<void> addResult;
  final ApiResult<void> removeResult;

  const FakeWishlistRepository({
    required this.getResult,
    this.addResult = const ApiSuccess(null),
    required this.removeResult,
  });

  @override
  Stream<List<ProductEntity>> get wishlistStream => const Stream.empty();

  @override
  Future<ApiResult<List<ProductEntity>>> getWishlist() async => getResult;

  @override
  Future<ApiResult<void>> addToWishlist(ProductEntity product) async => addResult;

  @override
  Future<ApiResult<void>> removeFromWishlist(String productId) async =>
      removeResult;
}

void main() {
  const dummyProduct = ProductEntity(
    id: '1',
    brand: 'MANGO',
    name: 'Wide Leg Trousers',
    price: 1590,
    imageUrl: 'https://example.com/item.jpg',
    isWishlisted: true,
  );

  test('GetWishlistUseCase returns ApiSuccess when repository succeeds', () async {
    const repository = FakeWishlistRepository(
      getResult: ApiSuccess([dummyProduct]),
      removeResult: ApiSuccess(null),
    );
    final useCase = GetWishlistUseCase(repository);

    final result = await useCase();

    expect(result, isA<ApiSuccess<List<ProductEntity>>>());
    expect((result as ApiSuccess<List<ProductEntity>>).data, [dummyProduct]);
  });

  test('AddToWishlistUseCase succeeds', () async {
    const repository = FakeWishlistRepository(
      getResult: ApiSuccess([dummyProduct]),
      addResult: ApiSuccess(null),
      removeResult: ApiSuccess(null),
    );
    final useCase = AddToWishlistUseCase(repository);

    final result = await useCase(dummyProduct);

    expect(result, isA<ApiSuccess<void>>());
  });

  test('RemoveFromWishlistUseCase returns success', () async {
    const repository = FakeWishlistRepository(
      getResult: ApiSuccess([dummyProduct]),
      removeResult: ApiSuccess(null),
    );
    final useCase = RemoveFromWishlistUseCase(repository);

    final result = await useCase('1');

    expect(result, isA<ApiSuccess<void>>());
  });
}
