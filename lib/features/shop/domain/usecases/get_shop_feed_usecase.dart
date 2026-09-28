import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';
import 'package:looks_loop/features/shop/domain/repositories/shop_repository.dart';

class GetShopFeedUseCase {
  final ShopRepository _repository;

  const GetShopFeedUseCase(this._repository);

  Future<ApiResult<ShopFeedData>> call() async {
    return await _repository.getShopFeed();
  }
}
