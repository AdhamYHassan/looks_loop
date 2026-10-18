import 'package:looks_loop/core/network/network_exceptions.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/brands/data/datasources/brands_remote_data_source.dart';
import 'package:looks_loop/features/brands/domain/entities/brand_entity.dart';
import 'package:looks_loop/features/brands/domain/entities/get_brands_params.dart';
import 'package:looks_loop/features/brands/domain/repositories/brands_repository.dart';

class BrandsRepositoryImpl implements BrandsRepository {
  final BrandsRemoteDataSource _remoteDataSource;

  const BrandsRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<List<BrandEntity>>> getBrands(GetBrandsParams params) async {
    try {
      final models = await _remoteDataSource.getBrands(params);
      return ApiSuccess(models);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }
}
