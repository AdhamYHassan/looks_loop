import 'package:dio/dio.dart';
import 'package:looks_loop/core/helpers/secure_storage_helper.dart';
import 'package:looks_loop/core/network/api_endpoints.dart';
import 'package:looks_loop/core/network/inetwork_helper.dart';
import 'package:looks_loop/features/cart/data/models/add_to_cart_request_model.dart';
import 'package:looks_loop/features/cart/data/models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCart();
  Future<CartModel> addToCart(AddToCartRequestModel request);
  Future<CartModel> updateQuantity({required String itemId, required int quantity});
  Future<CartModel> removeItem(String itemId);
  Future<CartModel> applyPromoCode(String promoCode);
  Future<CartModel> removePromoCode();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final InetworkHelper _networkHelper;

  const CartRemoteDataSourceImpl(this._networkHelper);

  Future<CartModel> _handleCartResponse(Response response) async {
    final body = response.data as Map<String, dynamic>;
    final data = body['data'] as Map<String, dynamic>? ?? body;

    final cartToken = data['cart_token']?.toString();
    if (cartToken != null && cartToken.isNotEmpty) {
      await SecureStorageHelper.saveCartToken(cartToken);
    }

    return CartModel.fromJson(data);
  }

  @override
  Future<CartModel> getCart() async {
    final response = await _networkHelper.get(ApiEndpoints.cart);
    return _handleCartResponse(response);
  }

  @override
  Future<CartModel> addToCart(AddToCartRequestModel request) async {
    final response = await _networkHelper.post(
      ApiEndpoints.cartItems,
      data: request.toJson(),
    );
    return _handleCartResponse(response);
  }

  @override
  Future<CartModel> updateQuantity({
    required String itemId,
    required int quantity,
  }) async {
    final cartToken = await SecureStorageHelper.getCartToken();
    final queryParams = <String, dynamic>{};
    if (cartToken != null && cartToken.isNotEmpty) {
      queryParams['cart_id'] = cartToken;
    }
    final response = await _networkHelper.patch(
      '${ApiEndpoints.cartItems}$itemId/',
      data: {'quantity': quantity},
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
    return _handleCartResponse(response);
  }

  @override
  Future<CartModel> removeItem(String itemId) async {
    final cartToken = await SecureStorageHelper.getCartToken();
    final queryParams = <String, dynamic>{};
    if (cartToken != null && cartToken.isNotEmpty) {
      queryParams['cart_id'] = cartToken;
    }
    final response = await _networkHelper.delete(
      '${ApiEndpoints.cartItems}$itemId/',
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
    return _handleCartResponse(response);
  }

  @override
  Future<CartModel> applyPromoCode(String promoCode) async {
    final cartToken = await SecureStorageHelper.getCartToken();
    final queryParams = <String, dynamic>{};
    if (cartToken != null && cartToken.isNotEmpty) {
      queryParams['cart_id'] = cartToken;
    }
    final response = await _networkHelper.post(
      '${ApiEndpoints.cart}voucher/',
      data: {'code': promoCode},
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
    return _handleCartResponse(response);
  }

  @override
  Future<CartModel> removePromoCode() async {
    final cartToken = await SecureStorageHelper.getCartToken();
    final queryParams = <String, dynamic>{};
    if (cartToken != null && cartToken.isNotEmpty) {
      queryParams['cart_id'] = cartToken;
    }
    final response = await _networkHelper.delete(
      '${ApiEndpoints.cart}voucher/',
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
    return _handleCartResponse(response);
  }
}
