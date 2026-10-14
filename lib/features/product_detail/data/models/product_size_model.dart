import 'package:looks_loop/features/product_detail/domain/entities/product_size_entity.dart';

class ProductSizeModel extends ProductSizeEntity {
  const ProductSizeModel({
    required super.id,
    required super.label,
  });

  factory ProductSizeModel.fromJson(Map<String, dynamic> json) {
    return ProductSizeModel(
      id: json['id'] as int? ?? 0,
      label: json['label'] as String? ?? '',
    );
  }
}
