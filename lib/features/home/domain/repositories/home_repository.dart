import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';

abstract class HomeRepository {
  Future<ApiResult<HomeFeedData>> getHomeFeed();
}
