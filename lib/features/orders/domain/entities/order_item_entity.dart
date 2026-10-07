import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  final int id;
  final int productId;
  final String productSlug;
  final String name;
  final String brandName;
  final String variant;
  final String image;
  final double unitPrice;
  final int quantity;
  final double lineTotal;

  const OrderItemEntity({
    required this.id,
    required this.productId,
    required this.productSlug,
    required this.name,
    required this.brandName,
    required this.variant,
    required this.image,
    required this.unitPrice,
    required this.quantity,
    required this.lineTotal,
  });

  @override
  List<Object?> get props => [
        id,
        productId,
        productSlug,
        name,
        brandName,
        variant,
        image,
        unitPrice,
        quantity,
        lineTotal,
      ];
}
