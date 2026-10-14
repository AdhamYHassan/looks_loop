import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/watch_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_cubit.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_state.dart';

class MockWishlistRepository implements WishlistRepository {
  ApiResult<List<ProductEntity>> getResult;
  ApiResult<void> addResult;
  ApiResult<void> removeResult;

  MockWishlistRepository({
    required this.getResult,
    this.addResult = const ApiSuccess(null),
    required this.removeResult,
  });

  @override
  Stream<List<ProductEntity>> get wishlistStream => const Stream.empty();

  @override
  Future<ApiResult<List<ProductEntity>>> getWishlist() async => getResult;

  @override
  Future<ApiResult<void>> addToWishlist(ProductEntity product) async =>
      addResult;

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

  test('WishlistCubit emits [WishlistLoading, WishlistLoaded] on successful fetch',
      () async {
    final repo = MockWishlistRepository(
      getResult: const ApiSuccess([dummyProduct]),
      removeResult: const ApiSuccess(null),
    );
    final cubit = WishlistCubit(
      GetWishlistUseCase(repo),
      AddToWishlistUseCase(repo),
      RemoveFromWishlistUseCase(repo),
      WatchWishlistUseCase(repo),
    );

    expectLater(
      cubit.stream,
      emitsInOrder([
        const WishlistLoading(),
        const WishlistLoaded(items: [dummyProduct]),
      ]),
    );

    await cubit.fetchWishlist();
    cubit.close();
  });

  test('WishlistCubit emits [WishlistLoading, WishlistError] on failure',
      () async {
    final repo = MockWishlistRepository(
      getResult: const ApiFailure(ServerFailure('Connection failed')),
      removeResult: const ApiSuccess(null),
    );
    final cubit = WishlistCubit(
      GetWishlistUseCase(repo),
      AddToWishlistUseCase(repo),
      RemoveFromWishlistUseCase(repo),
      WatchWishlistUseCase(repo),
    );

    expectLater(
      cubit.stream,
      emitsInOrder([
        const WishlistLoading(),
        const WishlistError('Connection failed'),
      ]),
    );

    await cubit.fetchWishlist();
    cubit.close();
  });

  test('WishlistCubit removes item correctly and emits updated WishlistLoaded',
      () async {
    final repo = MockWishlistRepository(
      getResult: const ApiSuccess([dummyProduct]),
      removeResult: const ApiSuccess(null),
    );
    final cubit = WishlistCubit(
      GetWishlistUseCase(repo),
      AddToWishlistUseCase(repo),
      RemoveFromWishlistUseCase(repo),
      WatchWishlistUseCase(repo),
    );

    await cubit.fetchWishlist();
    expect(cubit.state, const WishlistLoaded(items: [dummyProduct]));

    await cubit.removeItem('1');
    expect(cubit.state, const WishlistLoaded(items: []));

    cubit.close();
  });

  test('WishlistCubit toggleItem removes if present and adds if absent', () async {
    final repo = MockWishlistRepository(
      getResult: const ApiSuccess([dummyProduct]),
      removeResult: const ApiSuccess(null),
    );
    final cubit = WishlistCubit(
      GetWishlistUseCase(repo),
      AddToWishlistUseCase(repo),
      RemoveFromWishlistUseCase(repo),
      WatchWishlistUseCase(repo),
    );

    await cubit.fetchWishlist();
    expect(cubit.isItemWishlisted('1'), isTrue);

    await cubit.toggleItem(dummyProduct);
    expect(cubit.isItemWishlisted('1'), isFalse);

    await cubit.toggleItem(dummyProduct);
    expect(cubit.isItemWishlisted('1'), isTrue);

    cubit.close();
  });
}
