import 'package:looks_loop/core/network/api_endpoints.dart';
import 'package:looks_loop/core/network/inetwork_helper.dart';
import 'package:looks_loop/features/product_detail/data/models/product_detail_model.dart';

abstract class ProductDetailRemoteDataSource {
  Future<ProductDetailModel> getProductDetail(String slug);
}

class ProductDetailRemoteDataSourceImpl implements ProductDetailRemoteDataSource {
  final InetworkHelper _networkHelper;

  const ProductDetailRemoteDataSourceImpl(this._networkHelper);

  @override
  Future<ProductDetailModel> getProductDetail(String slug) async {
    final response = await _networkHelper.get('${ApiEndpoints.products}$slug/');
    final body = response.data as Map<String, dynamic>;
    final data = body['data'] as Map<String, dynamic>? ?? body;
    return ProductDetailModel.fromJson(data);
  }
}
