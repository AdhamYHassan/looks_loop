import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';

class ShopAudienceEntity extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final bool isLarge;

  const ShopAudienceEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isLarge = false,
  });

  @override
  List<Object?> get props => [id, title, imageUrl, isLarge];
}

class ShopCategoryEntity extends Equatable {
  final String id;
  final String name;
  final int productCount;
  final String imageUrl;

  const ShopCategoryEntity({
    required this.id,
    required this.name,
    required this.productCount,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, productCount, imageUrl];
}

class ShopEditorialEntity extends Equatable {
  final String eyebrow;
  final String titleLine1;
  final String titleLine2;
  final String ctaText;
  final String imageUrl;

  const ShopEditorialEntity({
    required this.eyebrow,
    required this.titleLine1,
    required this.titleLine2,
    required this.ctaText,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [eyebrow, titleLine1, titleLine2, ctaText, imageUrl];
}

class ShopSaleBannerEntity extends Equatable {
  final String eyebrow;
  final String title;
  final String subTitle;
  final String ctaText;

  const ShopSaleBannerEntity({
    required this.eyebrow,
    required this.title,
    required this.subTitle,
    required this.ctaText,
  });

  @override
  List<Object?> get props => [eyebrow, title, subTitle, ctaText];
}

class ShopFeedData extends Equatable {
  final List<ShopAudienceEntity> audiences;
  final List<String> quickLinks;
  final List<ShopCategoryEntity> categories;
  final ShopEditorialEntity editorial;
  final List<ProductEntity> newInProducts;
  final ShopSaleBannerEntity saleBanner;
  final List<BrandEntity> brands;

  const ShopFeedData({
    required this.audiences,
    required this.quickLinks,
    required this.categories,
    required this.editorial,
    required this.newInProducts,
    required this.saleBanner,
    required this.brands,
  });

  @override
  List<Object?> get props => [
        audiences,
        quickLinks,
        categories,
        editorial,
        newInProducts,
        saleBanner,
        brands,
      ];
}
