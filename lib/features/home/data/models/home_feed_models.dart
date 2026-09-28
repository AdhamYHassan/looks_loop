import 'package:looks_loop/features/home/data/models/product_models.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';

export 'package:looks_loop/features/home/data/models/product_models.dart';

class HomeFeedModel extends HomeFeedData {
  const HomeFeedModel({
    required super.heroSlides,
    required super.categories,
    required super.newInProducts,
    required super.trendingItems,
    required super.curatedLook,
    required super.motionReels,
    required super.brands,
  });

  factory HomeFeedModel.fromJson(Map<String, dynamic> json) {
    return HomeFeedModel(
      heroSlides: (json['hero_slides'] as List<dynamic>? ?? [])
          .map((e) => HeroSlideModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      newInProducts: (json['new_in_products'] as List<dynamic>? ?? [])
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      trendingItems: (json['trending_items'] as List<dynamic>? ?? [])
          .map((e) => TrendingItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      curatedLook: CuratedLookModel.fromJson(
        json['curated_look'] as Map<String, dynamic>? ?? {},
      ),
      motionReels: (json['motion_reels'] as List<dynamic>? ?? [])
          .map((e) => MotionReelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      brands: (json['brands'] as List<dynamic>? ?? [])
          .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class HeroSlideModel extends HeroSlideEntity {
  const HeroSlideModel({
    required super.id,
    required super.imageUrl,
    required super.eyebrow,
    required super.title,
    required super.copy,
    required super.ctaText,
  });

  factory HeroSlideModel.fromJson(Map<String, dynamic> json) {
    return HeroSlideModel(
      id: json['id'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      eyebrow: json['eyebrow'] as String? ?? '',
      title: json['title'] as String? ?? '',
      copy: json['copy'] as String? ?? '',
      ctaText: json['cta_text'] as String? ?? '',
    );
  }
}

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
    );
  }
}

class BrandModel extends BrandEntity {
  const BrandModel({
    required super.id,
    required super.name,
    required super.logoAssetOrUrl,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      logoAssetOrUrl: json['logo_asset_or_url'] as String? ?? '',
    );
  }
}
