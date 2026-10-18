import 'package:looks_loop/features/brands/domain/entities/brand_entity.dart';

class BrandModel extends BrandEntity {
  const BrandModel({
    required super.id,
    required super.name,
    super.slug,
    super.description,
    required super.logo,
    super.coverImage,
    super.isFeatured,
    super.productCount,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String? ?? '',
      logo: json['logo'] as String? ?? '',
      coverImage: json['cover_image'] as String? ?? '',
      isFeatured: json['is_featured'] as bool? ?? false,
      productCount: json['product_count'] as int? ?? 0,
    );
  }
}
