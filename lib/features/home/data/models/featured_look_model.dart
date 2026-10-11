import 'package:looks_loop/features/home/data/models/product_models.dart';
import 'package:looks_loop/features/home/domain/entities/featured_look_entity.dart';

class LookHotspotModel extends LookHotspotEntity {
  const LookHotspotModel({
    required super.x,
    required super.y,
    required super.product,
  });

  factory LookHotspotModel.fromJson(Map<String, dynamic> json) {
    final rawProduct = json['product'] as Map<String, dynamic>? ?? const {};
    return LookHotspotModel(
      x: (json['x'] as num?)?.toDouble() ?? 0.0,
      y: (json['y'] as num?)?.toDouble() ?? 0.0,
      product: ProductModel.fromJson(rawProduct),
    );
  }
}

class FeaturedLookModel extends FeaturedLookEntity {
  const FeaturedLookModel({
    required super.id,
    required super.slug,
    required super.title,
    required super.description,
    required super.imageUrl,
    super.isFeatured,
    super.hotspots,
  });

  factory FeaturedLookModel.fromJson(Map<String, dynamic> json) {
    final rawHotspots = json['hotspots'] as List<dynamic>? ?? const [];
    final hotspots = rawHotspots
        .whereType<Map<String, dynamic>>()
        .map(LookHotspotModel.fromJson)
        .toList();

    return FeaturedLookModel(
      id: json['id'] as int? ?? 0,
      slug: json['slug'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['image'] as String? ?? '',
      isFeatured: json['is_featured'] as bool? ?? true,
      hotspots: hotspots,
    );
  }
}
