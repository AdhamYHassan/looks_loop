import 'package:looks_loop/core/network/network_helper.dart';
import 'package:looks_loop/features/brands/data/models/brand_model.dart';
import 'package:looks_loop/features/brands/domain/entities/get_brands_params.dart';

abstract interface class BrandsRemoteDataSource {
  Future<List<BrandModel>> getBrands(GetBrandsParams params);
}

class BrandsRemoteDataSourceImpl implements BrandsRemoteDataSource {
  final NetworkHelper _networkHelper;

  const BrandsRemoteDataSourceImpl(this._networkHelper);

  @override
  Future<List<BrandModel>> getBrands(GetBrandsParams params) async {
    final response = await _networkHelper.get(
      'brands/',
      queryParameters: params.toQueryParameters(),
    );

    final responseData = response.data as Map<String, dynamic>;
    final dataList = responseData['data'] as List<dynamic>? ?? const [];

    return dataList
        .map((item) => BrandModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
