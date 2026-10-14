import 'package:equatable/equatable.dart';

class ProductVariantEntity extends Equatable {
  final int id;
  final String sku;
  final int colorId;
  final int sizeId;
  final int stock;
  final bool isAvailable;

  const ProductVariantEntity({
    required this.id,
    required this.sku,
    required this.colorId,
    required this.sizeId,
    required this.stock,
    required this.isAvailable,
  });

  @override
  List<Object?> get props => [
        id,
        sku,
        colorId,
        sizeId,
        stock,
        isAvailable,
      ];
}
