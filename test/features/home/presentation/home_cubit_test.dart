import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/domain/repositories/home_repository.dart';
import 'package:looks_loop/features/home/domain/usecases/get_cached_announcements_usecase.dart';
import 'package:looks_loop/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_cubit.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_state.dart';
import 'package:looks_loop/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/watch_wishlist_usecase.dart';

class FakeSuccessHomeRepository implements HomeRepository {
  final HomeFeedData data;
  final List<String> cachedAnnouncements;

  const FakeSuccessHomeRepository(
    this.data, {
    this.cachedAnnouncements = const [],
  });

  @override
  Future<ApiResult<HomeFeedData>> getHomeFeed() async => ApiSuccess(data);

  @override
  Future<List<String>> getCachedAnnouncements() async => cachedAnnouncements;
}

class FakeFailureHomeRepository implements HomeRepository {
  final List<String> cachedAnnouncements;

  const FakeFailureHomeRepository({this.cachedAnnouncements = const []});

  @override
  Future<ApiResult<HomeFeedData>> getHomeFeed() async =>
      const ApiFailure(ServerFailure('Failed to fetch feed'));

  @override
  Future<List<String>> getCachedAnnouncements() async => cachedAnnouncements;
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
    announcements: ['NEW DROPS EVERY FRIDAY — 8 PM'],
    categories: [],
    newInProducts: [dummyProduct],
    trendingProducts: [],
    brands: [],
  );

  test('HomeCubit emits [HomeLoading, HomeLoaded] upon successful fetch',
      () async {
    final repo = const FakeSuccessHomeRepository(dummyFeedData);
    final useCase = GetHomeFeedUseCase(repo);
    final cacheUseCase = GetCachedAnnouncementsUseCase(repo);
    final wishlistRepo = FakeWishlistRepo();
    final cubit = HomeCubit(
      useCase,
      cacheUseCase,
      AddToWishlistUseCase(wishlistRepo),
      RemoveFromWishlistUseCase(wishlistRepo),
      WatchWishlistUseCase(wishlistRepo),
    );

    final expectedStates = [
      const HomeLoading(),
      const HomeLoaded(
        feedData: dummyFeedData,
        cachedAnnouncements: ['NEW DROPS EVERY FRIDAY — 8 PM'],
      ),
    ];

    expectLater(cubit.stream, emitsInOrder(expectedStates));

    await cubit.fetchHomeFeed();
    cubit.close();
  });

  test('HomeCubit emits [HomeLoading, HomeError] upon failure', () async {
    final repo = const FakeFailureHomeRepository();
    final useCase = GetHomeFeedUseCase(repo);
    final cacheUseCase = GetCachedAnnouncementsUseCase(repo);
    final wishlistRepo = FakeWishlistRepo();
    final cubit = HomeCubit(
      useCase,
      cacheUseCase,
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

  test('HomeCubit exposes cached announcements immediately without waiting for fetch', () async {
    final repo = const FakeSuccessHomeRepository(
      dummyFeedData,
      cachedAnnouncements: ['CACHED ANNOUNCEMENT 1'],
    );
    final useCase = GetHomeFeedUseCase(repo);
    final cacheUseCase = GetCachedAnnouncementsUseCase(repo);
    final wishlistRepo = FakeWishlistRepo();
    final cubit = HomeCubit(
      useCase,
      cacheUseCase,
      AddToWishlistUseCase(wishlistRepo),
      RemoveFromWishlistUseCase(wishlistRepo),
      WatchWishlistUseCase(wishlistRepo),
    );

    // Initial check after loading cached
    await pumpEventQueue();
    expect(cubit.state.announcements, ['CACHED ANNOUNCEMENT 1']);

    cubit.close();
  });

  test('HomeCubit toggles wishlist productId and syncs via stream', () async {
    final repo = const FakeSuccessHomeRepository(dummyFeedData);
    final useCase = GetHomeFeedUseCase(repo);
    final cacheUseCase = GetCachedAnnouncementsUseCase(repo);
    final wishlistRepo = FakeWishlistRepo();
    final cubit = HomeCubit(
      useCase,
      cacheUseCase,
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

