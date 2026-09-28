import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/shop/data/datasources/shop_remote_data_source.dart';
import 'package:looks_loop/features/shop/data/models/shop_feed_models.dart';
import 'package:looks_loop/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';

class FakeShopRemoteDataSource implements ShopRemoteDataSource {
  final bool shouldThrow;

  const FakeShopRemoteDataSource({this.shouldThrow = false});

  @override
  Future<ShopFeedModel> getShopFeed() async {
    if (shouldThrow) {
      throw const FormatException('Corrupted response');
    }
    return const ShopFeedModel(
      audiences: [],
      quickLinks: [],
      categories: [],
      editorial: ShopEditorialModel(
        eyebrow: '',
        titleLine1: '',
        titleLine2: '',
        ctaText: '',
        imageUrl: '',
      ),
      newInProducts: [],
      saleBanner: ShopSaleBannerModel(
        eyebrow: '',
        title: '',
        subTitle: '',
        ctaText: '',
      ),
      brands: [],
    );
  }
}

void main() {
  test('returns ApiSuccess when remote data source succeeds', () async {
    const dataSource = FakeShopRemoteDataSource();
    final repository = ShopRepositoryImpl(dataSource);

    final result = await repository.getShopFeed();

    expect(result, isA<ApiSuccess<ShopFeedData>>());
  });

  test('returns ApiFailure with ServerFailure when FormatException is thrown', () async {
    const dataSource = FakeShopRemoteDataSource(shouldThrow: true);
    final repository = ShopRepositoryImpl(dataSource);

    final result = await repository.getShopFeed();

    expect(result, isA<ApiFailure<ShopFeedData>>());
    expect((result as ApiFailure<ShopFeedData>).failure, isA<ServerFailure>());
  });
}
