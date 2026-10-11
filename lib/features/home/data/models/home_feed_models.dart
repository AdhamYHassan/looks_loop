import 'package:looks_loop/features/home/data/models/home_sub_models.dart';
import 'package:looks_loop/features/home/data/models/product_models.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';

export 'package:looks_loop/features/home/data/models/home_sub_models.dart';
export 'package:looks_loop/features/home/data/models/product_models.dart';

class HomeFeedModel extends HomeFeedData {
  const HomeFeedModel({
    required super.heroSlides,
    super.announcements,
    required super.categories,
    required super.newInProducts,
    required super.trendingProducts,
    super.featuredLoops,
    super.featuredLook,
    required super.brands,
    super.saleProducts,
    super.editorial,
  });

  factory HomeFeedModel.fromJson(Map<String, dynamic> json) {
    final root = json.containsKey('data') && json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final heroSlides = (root['hero_slides'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(HeroSlideModel.fromJson)
        .toList();

    final announcements = (root['announcements'] as List<dynamic>? ?? const [])
        .map((e) => e.toString())
        .toList();

    final categories = (root['categories'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(CategoryModel.fromJson)
        .toList();

    final newIn = (root['new_in'] as List<dynamic>? ?? (root['new_in_products'] as List<dynamic>? ?? const []))
        .whereType<Map<String, dynamic>>()
        .map(ProductModel.fromJson)
        .toList();

    final trending = (root['trending'] as List<dynamic>? ?? (root['trending_items'] as List<dynamic>? ?? const []))
        .whereType<Map<String, dynamic>>()
        .map(ProductModel.fromJson)
        .toList();

    final loops = (root['featured_loops'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(FeaturedLoopModel.fromJson)
        .toList();

    final rawLook = root['featured_look'] ?? root['curated_look'];
    final featuredLook = rawLook is Map<String, dynamic> && rawLook.isNotEmpty
        ? FeaturedLookModel.fromJson(rawLook)
        : null;

    final brands = (root['brands_to_know'] as List<dynamic>? ?? (root['brands'] as List<dynamic>? ?? const []))
        .whereType<Map<String, dynamic>>()
        .map(HomeBrandModel.fromJson)
        .toList();

    final sale = (root['sale'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(ProductModel.fromJson)
        .toList();

    final rawEditorial = root['editorial'];
    final editorial = rawEditorial is Map<String, dynamic> && rawEditorial.isNotEmpty
        ? EditorialModel.fromJson(rawEditorial)
        : null;

    return HomeFeedModel(
      heroSlides: heroSlides,
      announcements: announcements,
      categories: categories,
      newInProducts: newIn,
      trendingProducts: trending,
      featuredLoops: loops,
      featuredLook: featuredLook,
      brands: brands,
      saleProducts: sale,
      editorial: editorial,
    );
  }
}
