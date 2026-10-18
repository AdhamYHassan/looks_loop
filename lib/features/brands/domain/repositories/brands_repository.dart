import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/brands/domain/entities/brand_entity.dart';
import 'package:looks_loop/features/brands/domain/entities/get_brands_params.dart';

abstract interface class BrandsRepository {
  Future<ApiResult<List<BrandEntity>>> getBrands(GetBrandsParams params);
}
