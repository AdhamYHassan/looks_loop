import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/cart/domain/entities/add_to_cart_params.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<ApiResult<CartEntity>> getCart();
  Future<ApiResult<void>> addToCart(AddToCartParams params);
  Future<ApiResult<CartEntity>> updateQuantity({
    required String itemId,
    required int quantity,
  });
  Future<ApiResult<CartEntity>> removeItem(String itemId);
  Future<ApiResult<CartEntity>> applyPromoCode(String promoCode);
  Future<ApiResult<CartEntity>> removePromoCode();
}

