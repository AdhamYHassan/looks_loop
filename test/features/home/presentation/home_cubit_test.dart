import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/domain/repositories/home_repository.dart';
import 'package:looks_loop/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_cubit.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_state.dart';
import 'package:looks_loop/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/watch_wishlist_usecase.dart';

class FakeSuccessHomeRepository implements HomeRepository {
  final HomeFeedData data;
  const FakeSuccessHomeRepository(this.data);

  @override
  Future<ApiResult<HomeFeedData>> getHomeFeed() async => ApiSuccess(data);
}

class FakeFailureHomeRepository implements HomeRepository {
  const FakeFailureHomeRepository();

  @override
  Future<ApiResult<HomeFeedData>> getHomeFeed() async =>
      const ApiFailure(ServerFailure('Failed to fetch feed'));
}

class FakeWishlistRepo implements WishlistRepository {
  final ApiResult<void> addResult;
  final ApiResult<void> removeResult;
  final StreamController<List<ProductEntity>> _controller =
      StreamController<List<ProductEntity>>.broadcast();

  FakeWishlistRepo({
    this.addResult = const ApiSuccess(null),
    this.removeResult = const ApiSuccess(null),
  });

  @override
  Stream<List<ProductEntity>> get wishlistStream => _controller.stream;

  @override
  Future<ApiResult<List<ProductEntity>>> getWishlist() async =>
      const ApiSuccess([]);

  @override
  Future<ApiResult<void>> addToWishlist(ProductEntity product) async {
    _controller.add([product]);
    return addResult;
  }

  @override
  Future<ApiResult<void>> removeFromWishlist(String productId) async {
    _controller.add([]);
    return removeResult;
  }
}

void main() {
  const dummyProduct = ProductEntity(
    id: '101',
    brand: 'MANGO',
    name: 'Dress',
    price: 100,
    imageUrl: 'url',
  );

  const dummyFeedData = HomeFeedData(
    heroSlides: [],
    categories: [],
    newInProducts: [dummyProduct],
    trendingProducts: [],
    brands: [],
  );

  test('HomeCubit emits [HomeLoading, HomeLoaded] upon successful fetch',
      () async {
    final useCase = GetHomeFeedUseCase(
      const FakeSuccessHomeRepository(dummyFeedData),
    );
    final wishlistRepo = FakeWishlistRepo();
    final cubit = HomeCubit(
      useCase,
      AddToWishlistUseCase(wishlistRepo),
      RemoveFromWishlistUseCase(wishlistRepo),
      WatchWishlistUseCase(wishlistRepo),
    );

    final expectedStates = [
      const HomeLoading(),
      const HomeLoaded(feedData: dummyFeedData),
    ];

    expectLater(cubit.stream, emitsInOrder(expectedStates));

    await cubit.fetchHomeFeed();
    cubit.close();
  });

  test('HomeCubit emits [HomeLoading, HomeError] upon failure', () async {
    final useCase = GetHomeFeedUseCase(const FakeFailureHomeRepository());
    final wishlistRepo = FakeWishlistRepo();
    final cubit = HomeCubit(
      useCase,
      AddToWishlistUseCase(wishlistRepo),
      RemoveFromWishlistUseCase(wishlistRepo),
      WatchWishlistUseCase(wishlistRepo),
    );

    final expectedStates = [
      const HomeLoading(),
      const HomeError('Failed to fetch feed'),
    ];

    expectLater(cubit.stream, emitsInOrder(expectedStates));

    await cubit.fetchHomeFeed();
    cubit.close();
  });

  test('HomeCubit toggles wishlist productId and syncs via stream', () async {
    final useCase = GetHomeFeedUseCase(
      const FakeSuccessHomeRepository(dummyFeedData),
    );
    final wishlistRepo = FakeWishlistRepo();
    final cubit = HomeCubit(
      useCase,
      AddToWishlistUseCase(wishlistRepo),
      RemoveFromWishlistUseCase(wishlistRepo),
      WatchWishlistUseCase(wishlistRepo),
    );
    await cubit.fetchHomeFeed();

    await cubit.toggleWishlist('101');
    await pumpEventQueue();
    expect(
      (cubit.state as HomeLoaded).wishlistedProductIds,
      contains('101'),
    );

    await cubit.toggleWishlist('101');
    await pumpEventQueue();
    expect(
      (cubit.state as HomeLoaded).wishlistedProductIds,
      isNot(contains('101')),
    );

    cubit.close();
  });
}
