import 'package:equatable/equatable.dart';

class AddToCartParams extends Equatable {
  final int variantId;
  final int productId;
  final int colorId;
  final int sizeId;
  final int quantity;

  const AddToCartParams({
    required this.variantId,
    required this.productId,
    required this.colorId,
    required this.sizeId,
    this.quantity = 1,
  });

  @override
  List<Object?> get props => [
        variantId,
        productId,
        colorId,
        sizeId,
        quantity,
      ];
}
