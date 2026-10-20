import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/looks/domain/entities/look_entity.dart';

abstract interface class LooksRepository {
  Future<ApiResult<List<LookSummaryEntity>>> getLooks();
  Future<ApiResult<FeaturedLookEntity>> getLookDetail(String slug);
}
