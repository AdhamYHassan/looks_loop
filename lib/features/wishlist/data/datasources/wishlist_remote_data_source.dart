import 'package:looks_loop/core/network/api_endpoints.dart';
import 'package:looks_loop/core/network/inetwork_helper.dart';
import 'package:looks_loop/features/home/data/models/product_models.dart';
import 'package:looks_loop/features/wishlist/data/models/wishlist_add_request_model.dart';
import 'package:looks_loop/features/wishlist/data/models/wishlist_response_model.dart';

abstract interface class WishlistRemoteDataSource {
  Future<List<ProductModel>> getWishlist();
  Future<void> addToWishlist(int productId);
  Future<void> removeFromWishlist(int productId);
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final InetworkHelper _networkHelper;

  const WishlistRemoteDataSourceImpl(this._networkHelper);

  @override
  Future<List<ProductModel>> getWishlist() async {
    final response = await _networkHelper.get(ApiEndpoints.wishlist);
    final responseModel = WishlistResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
    return responseModel.items;
  }

  @override
  Future<void> addToWishlist(int productId) async {
    final request = WishlistAddRequestModel(productId: productId);
    await _networkHelper.post(
      ApiEndpoints.wishlist,
      data: request.toJson(),
    );
  }

  @override
  Future<void> removeFromWishlist(int productId) async {
    await _networkHelper.delete('${ApiEndpoints.wishlist}$productId/');
  }
}
