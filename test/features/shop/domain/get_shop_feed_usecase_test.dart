import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';
import 'package:looks_loop/features/shop/domain/repositories/shop_repository.dart';
import 'package:looks_loop/features/shop/domain/usecases/get_shop_feed_usecase.dart';

class FakeShopRepository implements ShopRepository {
  final ApiResult<ShopFeedData> result;

  const FakeShopRepository(this.result);

  @override
  Future<ApiResult<ShopFeedData>> getShopFeed() async => result;
}

void main() {
  const dummyFeedData = ShopFeedData(
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

  test('GetShopFeedUseCase should return ApiSuccess when repository succeeds', () async {
    const repository = FakeShopRepository(ApiSuccess(dummyFeedData));
    final useCase = GetShopFeedUseCase(repository);

    final result = await useCase();

    expect(result, isA<ApiSuccess<ShopFeedData>>());
    expect((result as ApiSuccess<ShopFeedData>).data, equals(dummyFeedData));
  });
}
