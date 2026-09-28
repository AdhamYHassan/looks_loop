import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_cubit.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_state.dart';

class MockWishlistRepository implements WishlistRepository {
  ApiResult<List<ProductEntity>> getResult;
  ApiResult<List<ProductEntity>> removeResult;

  MockWishlistRepository({
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

  test('WishlistCubit emits [WishlistLoading, WishlistLoaded] on successful fetch',
      () async {
    final repo = MockWishlistRepository(
      getResult: const ApiSuccess([dummyProduct]),
      removeResult: const ApiSuccess([]),
    );
    final cubit = WishlistCubit(
      GetWishlistUseCase(repo),
      RemoveFromWishlistUseCase(repo),
    );

    expectLater(
      cubit.stream,
      emitsInOrder([
        const WishlistLoading(),
        const WishlistLoaded(items: [dummyProduct]),
      ]),
    );

    await cubit.fetchWishlist();
  });

  test('WishlistCubit emits [WishlistLoading, WishlistError] on failure',
      () async {
    final repo = MockWishlistRepository(
      getResult: const ApiFailure(ServerFailure('Connection failed')),
      removeResult: const ApiSuccess([]),
    );
    final cubit = WishlistCubit(
      GetWishlistUseCase(repo),
      RemoveFromWishlistUseCase(repo),
    );

    expectLater(
      cubit.stream,
      emitsInOrder([
        const WishlistLoading(),
        const WishlistError('Connection failed'),
      ]),
    );

    await cubit.fetchWishlist();
  });

  test('WishlistCubit removes item and updates list correctly', () async {
    final repo = MockWishlistRepository(
      getResult: const ApiSuccess([dummyProduct]),
      removeResult: const ApiSuccess([]),
    );
    final cubit = WishlistCubit(
      GetWishlistUseCase(repo),
      RemoveFromWishlistUseCase(repo),
    );

    await cubit.fetchWishlist();
    await cubit.removeItem('w1');

    expect(cubit.state, const WishlistLoaded(items: []));
  });
}
