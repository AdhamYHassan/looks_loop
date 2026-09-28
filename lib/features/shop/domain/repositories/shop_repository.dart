import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';

abstract class ShopRepository {
  Future<ApiResult<ShopFeedData>> getShopFeed();
}
