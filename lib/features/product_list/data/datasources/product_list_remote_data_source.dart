import 'package:looks_loop/core/network/network_helper.dart';
import 'package:looks_loop/features/product_list/data/models/product_list_model.dart';
import 'package:looks_loop/features/product_list/domain/repositories/product_list_repository.dart';

abstract interface class ProductListRemoteDataSource {
  Future<ProductListModel> getProducts(GetProductsParams params);
}

class ProductListRemoteDataSourceImpl implements ProductListRemoteDataSource {
  final NetworkHelper _networkHelper;

  const ProductListRemoteDataSourceImpl(this._networkHelper);

  @override
  Future<ProductListModel> getProducts(GetProductsParams params) async {
    final response = await _networkHelper.get(
      'products/',
      queryParameters: params.toQueryParameters(),
    );
    return ProductListModel.fromJson(response.data as Map<String, dynamic>);
  }
}
