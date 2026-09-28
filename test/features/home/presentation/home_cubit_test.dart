import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/domain/repositories/home_repository.dart';
import 'package:looks_loop/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_cubit.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_state.dart';

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

void main() {
  const dummyFeedData = HomeFeedData(
    heroSlides: [],
    categories: [],
    newInProducts: [],
    trendingItems: [],
    curatedLook: CuratedLookEntity(
      id: '1',
      eyebrow: 'E',
      title: 'T',
      piecesLabel: 'P',
      imageUrl: 'I',
      ctaText: 'C',
    ),
    motionReels: [],
    brands: [],
  );

  test('HomeCubit emits [HomeLoading, HomeLoaded] upon successful fetch',
      () async {
    final useCase = GetHomeFeedUseCase(
      const FakeSuccessHomeRepository(dummyFeedData),
    );
    final cubit = HomeCubit(useCase);

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
    final cubit = HomeCubit(useCase);

    final expectedStates = [
      const HomeLoading(),
      const HomeError('Failed to fetch feed'),
    ];

    expectLater(cubit.stream, emitsInOrder(expectedStates));

    await cubit.fetchHomeFeed();
    cubit.close();
  });

  test('HomeCubit toggles wishlist productId correctly', () async {
    final useCase = GetHomeFeedUseCase(
      const FakeSuccessHomeRepository(dummyFeedData),
    );
    final cubit = HomeCubit(useCase);
    await cubit.fetchHomeFeed();

    cubit.toggleWishlist('prod_1');
    expect(
      (cubit.state as HomeLoaded).wishlistedProductIds,
      contains('prod_1'),
    );

    cubit.toggleWishlist('prod_1');
    expect(
      (cubit.state as HomeLoaded).wishlistedProductIds,
      isNot(contains('prod_1')),
    );

    cubit.close();
  });
}
