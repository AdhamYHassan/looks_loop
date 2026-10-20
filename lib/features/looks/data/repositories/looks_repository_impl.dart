import 'package:looks_loop/core/network/network_exceptions.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/looks/data/datasources/looks_remote_data_source.dart';
import 'package:looks_loop/features/looks/domain/entities/look_entity.dart';
import 'package:looks_loop/features/looks/domain/repositories/looks_repository.dart';

class LooksRepositoryImpl implements LooksRepository {
  final LooksRemoteDataSource _remoteDataSource;

  const LooksRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<List<LookSummaryEntity>>> getLooks() async {
    try {
      final models = await _remoteDataSource.getLooks();
      return ApiSuccess(models);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<FeaturedLookEntity>> getLookDetail(String slug) async {
    try {
      final model = await _remoteDataSource.getLookDetail(slug);
      return ApiSuccess(model);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }
}
