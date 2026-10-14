import 'package:looks_loop/features/product_detail/domain/entities/product_variant_entity.dart';

class ProductVariantModel extends ProductVariantEntity {
  const ProductVariantModel({
    required super.id,
    required super.sku,
    required super.colorId,
    required super.sizeId,
    required super.stock,
    required super.isAvailable,
  });

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantModel(
      id: json['id'] as int? ?? 0,
      sku: json['sku'] as String? ?? '',
      colorId: json['color_id'] as int? ?? 0,
      sizeId: json['size_id'] as int? ?? 0,
      stock: json['stock'] as int? ?? 0,
      isAvailable: json['is_available'] as bool? ?? false,
    );
  }
}
