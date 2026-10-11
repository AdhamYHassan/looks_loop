import 'package:looks_loop/features/home/domain/entities/home_brand_entity.dart';

typedef BrandModel = HomeBrandModel;

class HomeBrandModel extends HomeBrandEntity {
  const HomeBrandModel({
    required super.id,
    required super.name,
    super.slug,
    super.description,
    required super.logo,
    super.coverImage,
    super.isFeatured,
    super.productCount,
  });

  factory HomeBrandModel.fromJson(Map<String, dynamic> json) {
    return HomeBrandModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String? ?? '',
      logo:
          json['logo'] as String? ??
          (json['logo_asset_or_url'] as String? ?? ''),
      coverImage: json['cover_image'] as String? ?? '',
      isFeatured: json['is_featured'] as bool? ?? true,
      productCount: json['product_count'] as int? ?? 0,
    );
  }
}
