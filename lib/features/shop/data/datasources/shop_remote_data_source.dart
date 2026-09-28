import 'package:looks_loop/features/shop/data/datasources/shop_mock_data.dart';
import 'package:looks_loop/features/shop/data/models/shop_feed_models.dart';

abstract class ShopRemoteDataSource {
  Future<ShopFeedModel> getShopFeed();
}

class ShopRemoteDataSourceImpl implements ShopRemoteDataSource {
  const ShopRemoteDataSourceImpl();

  @override
  Future<ShopFeedModel> getShopFeed() async {
    // Simulates remote network latency
    await Future.delayed(const Duration(milliseconds: 350));
    return const ShopFeedModel(
      audiences: ShopMockData.audiences,
      quickLinks: ShopMockData.quickLinks,
      categories: ShopMockData.categories,
      editorial: ShopMockData.editorial,
      newInProducts: ShopMockData.newInProducts,
      saleBanner: ShopMockData.saleBanner,
      brands: ShopMockData.brands,
    );
  }
}
