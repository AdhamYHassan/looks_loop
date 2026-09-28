import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/shop/data/datasources/shop_remote_data_source.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';
import 'package:looks_loop/features/shop/domain/repositories/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDataSource _remoteDataSource;

  const ShopRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<ShopFeedData>> getShopFeed() async {
    try {
      final feedModel = await _remoteDataSource.getShopFeed();
      return ApiSuccess(feedModel);
    } on FormatException catch (e) {
      return ApiFailure(ServerFailure('Invalid data format: ${e.message}'));
    } catch (e) {
      return ApiFailure(UnknownFailure(e.toString()));
    }
  }
}
