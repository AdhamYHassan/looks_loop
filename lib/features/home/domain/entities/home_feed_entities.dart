import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/home/domain/entities/editorial_entity.dart';
import 'package:looks_loop/features/home/domain/entities/featured_look_entity.dart';
import 'package:looks_loop/features/home/domain/entities/featured_loop_entity.dart';
import 'package:looks_loop/features/home/domain/entities/home_brand_entity.dart';
import 'package:looks_loop/features/home/domain/entities/home_category_entity.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';

export 'package:looks_loop/features/home/domain/entities/editorial_entity.dart';
export 'package:looks_loop/features/home/domain/entities/featured_look_entity.dart';
export 'package:looks_loop/features/home/domain/entities/featured_loop_entity.dart';
export 'package:looks_loop/features/home/domain/entities/home_brand_entity.dart';
export 'package:looks_loop/features/home/domain/entities/home_category_entity.dart';
export 'package:looks_loop/features/home/domain/entities/product_entities.dart';

class HeroSlideEntity extends Equatable {
  final int id;
  final String eyebrow;
  final String title;
  final List<String> titleLines;
  final String copy;
  final String image;
  final String primaryLabel;
  final String primaryUrl;
  final String secondaryLabel;
  final String secondaryUrl;

  const HeroSlideEntity({
    required this.id,
    required this.eyebrow,
    required this.title,
    this.titleLines = const [],
    required this.copy,
    required this.image,
    required this.primaryLabel,
    this.primaryUrl = '',
    required this.secondaryLabel,
    this.secondaryUrl = '',
  });

  String get imageUrl => image;
  String get ctaText => primaryLabel;

  @override
  List<Object?> get props => [
        id,
        eyebrow,
        title,
        titleLines,
        copy,
        image,
        primaryLabel,
        primaryUrl,
        secondaryLabel,
        secondaryUrl,
      ];
}

class HomeFeedData extends Equatable {
  final List<HeroSlideEntity> heroSlides;
  final List<String> announcements;
  final List<CategoryEntity> categories;
  final List<ProductEntity> newInProducts;
  final List<ProductEntity> trendingProducts;
  final List<FeaturedLoopEntity> featuredLoops;
  final FeaturedLookEntity? featuredLook;
  final List<HomeBrandEntity> brands;
  final List<ProductEntity> saleProducts;
  final EditorialEntity? editorial;

  const HomeFeedData({
    required this.heroSlides,
    this.announcements = const [],
    required this.categories,
    required this.newInProducts,
    required this.trendingProducts,
    this.featuredLoops = const [],
    this.featuredLook,
    required this.brands,
    this.saleProducts = const [],
    this.editorial,
  });

  @override
  List<Object?> get props => [
        heroSlides,
        announcements,
        categories,
        newInProducts,
        trendingProducts,
        featuredLoops,
        featuredLook,
        brands,
        saleProducts,
        editorial,
      ];
}
