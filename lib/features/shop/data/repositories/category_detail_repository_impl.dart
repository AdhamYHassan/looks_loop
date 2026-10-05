import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/shop/data/datasources/category_detail_remote_data_source.dart';
import 'package:looks_loop/features/shop/domain/entities/category_detail_entity.dart';
import 'package:looks_loop/features/shop/domain/repositories/category_detail_repository.dart';

class CategoryDetailRepositoryImpl implements CategoryDetailRepository {
  final CategoryDetailRemoteDataSource _remoteDataSource;

  const CategoryDetailRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<CategoryDetailEntity>> getCategoryDetail(
    String audienceId,
  ) async {
    try {
      final model = await _remoteDataSource.getCategoryDetail(audienceId);
      return ApiSuccess(model);
    } on FormatException catch (e) {
      return ApiFailure(ServerFailure('Invalid data format: ${e.message}'));
    } catch (e) {
      return ApiFailure(UnknownFailure(e.toString()));
    }
  }
}
