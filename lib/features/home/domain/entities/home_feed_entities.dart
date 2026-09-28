import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';

export 'package:looks_loop/features/home/domain/entities/product_entities.dart';

class HomeFeedData extends Equatable {
  final List<HeroSlideEntity> heroSlides;
  final List<CategoryEntity> categories;
  final List<ProductEntity> newInProducts;
  final List<TrendingItemEntity> trendingItems;
  final CuratedLookEntity curatedLook;
  final List<MotionReelEntity> motionReels;
  final List<BrandEntity> brands;

  const HomeFeedData({
    required this.heroSlides,
    required this.categories,
    required this.newInProducts,
    required this.trendingItems,
    required this.curatedLook,
    required this.motionReels,
    required this.brands,
  });

  @override
  List<Object?> get props => [
        heroSlides,
        categories,
        newInProducts,
        trendingItems,
        curatedLook,
        motionReels,
        brands,
      ];
}

class HeroSlideEntity extends Equatable {
  final String id;
  final String imageUrl;
  final String eyebrow;
  final String title;
  final String copy;
  final String ctaText;

  const HeroSlideEntity({
    required this.id,
    required this.imageUrl,
    required this.eyebrow,
    required this.title,
    required this.copy,
    required this.ctaText,
  });

  @override
  List<Object?> get props => [id, imageUrl, eyebrow, title, copy, ctaText];
}

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, imageUrl];
}

class BrandEntity extends Equatable {
  final String id;
  final String name;
  final String logoAssetOrUrl;

  const BrandEntity({
    required this.id,
    required this.name,
    required this.logoAssetOrUrl,
  });

  @override
  List<Object?> get props => [id, name, logoAssetOrUrl];
}
