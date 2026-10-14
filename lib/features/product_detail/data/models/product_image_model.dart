import 'package:looks_loop/features/product_detail/domain/entities/product_image_entity.dart';

class ProductImageModel extends ProductImageEntity {
  const ProductImageModel({
    required super.id,
    required super.url,
    super.colorId,
    super.alt,
    super.isPrimary,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      id: json['id'] as int? ?? 0,
      url: json['url'] as String? ?? (json['image'] as String? ?? ''),
      colorId: json['color_id'] as int?,
      alt: json['alt'] as String? ?? '',
      isPrimary: json['is_primary'] as bool? ?? false,
    );
  }
}
