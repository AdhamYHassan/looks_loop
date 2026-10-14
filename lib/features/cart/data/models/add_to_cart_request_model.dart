import 'package:looks_loop/features/cart/domain/entities/add_to_cart_params.dart';

class AddToCartRequestModel extends AddToCartParams {
  const AddToCartRequestModel({
    required super.variantId,
    required super.productId,
    required super.colorId,
    required super.sizeId,
    super.quantity = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'variant_id': variantId,
      'product_id': productId,
      'color_id': colorId,
      'size_id': sizeId,
      'quantity': quantity,
    };
  }
}
