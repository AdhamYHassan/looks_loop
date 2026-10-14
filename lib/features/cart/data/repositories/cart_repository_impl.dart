import 'package:looks_loop/core/network/network_exceptions.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:looks_loop/features/cart/data/models/add_to_cart_request_model.dart';
import 'package:looks_loop/features/cart/domain/entities/add_to_cart_params.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';
import 'package:looks_loop/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;

  const CartRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<void>> addToCart(AddToCartParams params) async {
    try {
      final request = AddToCartRequestModel(
        variantId: params.variantId,
        productId: params.productId,
        colorId: params.colorId,
        sizeId: params.sizeId,
        quantity: params.quantity,
      );
      await _remoteDataSource.addToCart(request);
      return const ApiSuccess(null);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<CartEntity>> getCart() async {
    try {
      final cart = await _remoteDataSource.getCart();
      return ApiSuccess(cart);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<CartEntity>> updateQuantity({
    required String itemId,
    required int quantity,
  }) async {
    try {
      final cart = await _remoteDataSource.updateQuantity(
        itemId: itemId,
        quantity: quantity,
      );
      return ApiSuccess(cart);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<CartEntity>> removeItem(String itemId) async {
    try {
      final cart = await _remoteDataSource.removeItem(itemId);
      return ApiSuccess(cart);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<CartEntity>> applyPromoCode(String promoCode) async {
    try {
      final cart = await _remoteDataSource.applyPromoCode(promoCode);
      return ApiSuccess(cart);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<CartEntity>> removePromoCode() async {
    try {
      final cart = await _remoteDataSource.removePromoCode();
      return ApiSuccess(cart);
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }
}
