import 'package:looks_loop/features/home/data/models/product_models.dart';
import 'package:looks_loop/features/home/domain/entities/featured_loop_entity.dart';

class FeaturedLoopModel extends FeaturedLoopEntity {
  const FeaturedLoopModel({
    required super.id,
    required super.slug,
    required super.title,
    required super.creator,
    required super.thumbnail,
    super.videoUrl,
    super.views,
    super.likesCount,
    super.liked,
    super.brands,
    super.products,
  });

  factory FeaturedLoopModel.fromJson(Map<String, dynamic> json) {
    final rawBrands = json['brands'] as List<dynamic>? ?? const [];
    final rawProducts = json['products'] as List<dynamic>? ?? const [];
    return FeaturedLoopModel(
      id: json['id'] as int? ?? 0,
      slug: json['slug'] as String? ?? '',
      title: json['title'] as String? ?? '',
      creator: json['creator'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
      videoUrl: json['video'] as String? ?? '',
      views: json['views'] as int? ?? 0,
      likesCount: json['likes_count'] as int? ?? 0,
      liked: json['liked'] as bool? ?? false,
      brands: rawBrands.map((e) => e.toString()).toList(),
      products: rawProducts
          .whereType<Map<String, dynamic>>()
          .map(ProductModel.fromJson)
          .toList(),
    );
  }
}
