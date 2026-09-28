import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';
import 'package:looks_loop/features/shop/domain/repositories/shop_repository.dart';
import 'package:looks_loop/features/shop/domain/usecases/get_shop_feed_usecase.dart';
import 'package:looks_loop/features/shop/presentation/bloc/shop_cubit.dart';
import 'package:looks_loop/features/shop/presentation/bloc/shop_state.dart';

class MockShopRepository implements ShopRepository {
  final ApiResult<ShopFeedData> result;

  const MockShopRepository(this.result);

  @override
  Future<ApiResult<ShopFeedData>> getShopFeed() async => result;
}

void main() {
  const dummyFeed = ShopFeedData(
    audiences: [],
    quickLinks: ['NEW IN', 'SALE'],
    categories: [],
    editorial: ShopEditorialEntity(
      eyebrow: 'SUMMER',
      titleLine1: 'LINE 1',
      titleLine2: 'LINE 2',
      ctaText: 'DISCOVER',
      imageUrl: '',
    ),
    newInProducts: [],
    saleBanner: ShopSaleBannerEntity(
      eyebrow: 'SALE',
      title: 'UP TO 40%',
      subTitle: 'SELECTED',
      ctaText: 'SHOP',
    ),
    brands: [],
  );

  test('ShopCubit emits [ShopLoading, ShopLoaded] upon successful fetch', () async {
    const repository = MockShopRepository(ApiSuccess(dummyFeed));
    final useCase = GetShopFeedUseCase(repository);
    final cubit = ShopCubit(useCase);

    expectLater(
      cubit.stream,
      emitsInOrder([
        const ShopLoading(),
        const ShopLoaded(feedData: dummyFeed),
      ]),
    );

    await cubit.fetchShopFeed();
  });

  test('ShopCubit emits [ShopLoading, ShopError] upon failure', () async {
    const repository = MockShopRepository(
      ApiFailure(ServerFailure('Connection refused')),
    );
    final useCase = GetShopFeedUseCase(repository);
    final cubit = ShopCubit(useCase);

    expectLater(
      cubit.stream,
      emitsInOrder([
        const ShopLoading(),
        const ShopError('Connection refused'),
      ]),
    );

    await cubit.fetchShopFeed();
  });

  test('ShopCubit updates selected audience and quick link correctly', () async {
    const repository = MockShopRepository(ApiSuccess(dummyFeed));
    final useCase = GetShopFeedUseCase(repository);
    final cubit = ShopCubit(useCase);

    await cubit.fetchShopFeed();

    cubit.selectAudience('aud_men');
    expect(
      (cubit.state as ShopLoaded).selectedAudienceId,
      equals('aud_men'),
    );

    cubit.selectQuickLink('SALE');
    expect(
      (cubit.state as ShopLoaded).selectedQuickLink,
      equals('SALE'),
    );
  });
}
