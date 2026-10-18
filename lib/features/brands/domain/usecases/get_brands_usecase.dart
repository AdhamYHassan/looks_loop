import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/brands/domain/entities/brand_entity.dart';
import 'package:looks_loop/features/brands/domain/entities/get_brands_params.dart';
import 'package:looks_loop/features/brands/domain/repositories/brands_repository.dart';

class GetBrandsUseCase {
  final BrandsRepository _repository;

  const GetBrandsUseCase(this._repository);

  Future<ApiResult<List<BrandEntity>>> call([
    GetBrandsParams params = const GetBrandsParams(),
  ]) {
    return _repository.getBrands(params);
  }
}
