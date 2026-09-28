import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.brand,
    required super.name,
    required super.price,
    super.originalPrice,
    super.discountPercent,
    required super.imageUrl,
    super.isWishlisted,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      discountPercent: json['discount_percent'] as int?,
      imageUrl: json['image_url'] as String? ?? '',
      isWishlisted: json['is_wishlisted'] as bool? ?? false,
    );
  }
}

class TrendingItemModel extends TrendingItemEntity {
  const TrendingItemModel({
    required super.id,
    required super.brand,
    required super.name,
    required super.price,
    required super.imageUrl,
  });

  factory TrendingItemModel.fromJson(Map<String, dynamic> json) {
    return TrendingItemModel(
      id: json['id'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['image_url'] as String? ?? '',
    );
  }
}

class CuratedLookModel extends CuratedLookEntity {
  const CuratedLookModel({
    required super.id,
    required super.eyebrow,
    required super.title,
    required super.piecesLabel,
    required super.imageUrl,
    required super.ctaText,
  });

  factory CuratedLookModel.fromJson(Map<String, dynamic> json) {
    return CuratedLookModel(
      id: json['id'] as String? ?? '',
      eyebrow: json['eyebrow'] as String? ?? '',
      title: json['title'] as String? ?? '',
      piecesLabel: json['pieces_label'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      ctaText: json['cta_text'] as String? ?? '',
    );
  }
}

class MotionReelModel extends MotionReelEntity {
  const MotionReelModel({
    required super.id,
    required super.title,
    required super.views,
    required super.thumbnailUrl,
  });

  factory MotionReelModel.fromJson(Map<String, dynamic> json) {
    return MotionReelModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      views: json['views'] as String? ?? '',
      thumbnailUrl: json['thumbnail_url'] as String? ?? '',
    );
  }
}
