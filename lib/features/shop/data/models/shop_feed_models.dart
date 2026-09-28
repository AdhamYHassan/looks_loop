import 'package:looks_loop/features/home/data/models/home_feed_models.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';

class ShopAudienceModel extends ShopAudienceEntity {
  const ShopAudienceModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    super.isLarge = false,
  });

  factory ShopAudienceModel.fromJson(Map<String, dynamic> json) {
    return ShopAudienceModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      isLarge: json['is_large'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image_url': imageUrl,
        'is_large': isLarge,
      };
}

class ShopCategoryModel extends ShopCategoryEntity {
  const ShopCategoryModel({
    required super.id,
    required super.name,
    required super.productCount,
    required super.imageUrl,
  });

  factory ShopCategoryModel.fromJson(Map<String, dynamic> json) {
    return ShopCategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      productCount: (json['product_count'] as num?)?.toInt() ?? 0,
      imageUrl: json['image_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'product_count': productCount,
        'image_url': imageUrl,
      };
}

class ShopEditorialModel extends ShopEditorialEntity {
  const ShopEditorialModel({
    required super.eyebrow,
    required super.titleLine1,
    required super.titleLine2,
    required super.ctaText,
    required super.imageUrl,
  });

  factory ShopEditorialModel.fromJson(Map<String, dynamic> json) {
    return ShopEditorialModel(
      eyebrow: json['eyebrow'] as String? ?? '',
      titleLine1: json['title_line1'] as String? ?? '',
      titleLine2: json['title_line2'] as String? ?? '',
      ctaText: json['cta_text'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'eyebrow': eyebrow,
        'title_line1': titleLine1,
        'title_line2': titleLine2,
        'cta_text': ctaText,
        'image_url': imageUrl,
      };
}

class ShopSaleBannerModel extends ShopSaleBannerEntity {
  const ShopSaleBannerModel({
    required super.eyebrow,
    required super.title,
    required super.subTitle,
    required super.ctaText,
  });

  factory ShopSaleBannerModel.fromJson(Map<String, dynamic> json) {
    return ShopSaleBannerModel(
      eyebrow: json['eyebrow'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subTitle: json['sub_title'] as String? ?? '',
      ctaText: json['cta_text'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'eyebrow': eyebrow,
        'title': title,
        'sub_title': subTitle,
        'cta_text': ctaText,
      };
}

class ShopFeedModel extends ShopFeedData {
  const ShopFeedModel({
    required super.audiences,
    required super.quickLinks,
    required super.categories,
    required super.editorial,
    required super.newInProducts,
    required super.saleBanner,
    required super.brands,
  });

  factory ShopFeedModel.fromJson(Map<String, dynamic> json) {
    return ShopFeedModel(
      audiences: ((json['audiences'] as List<dynamic>?) ?? [])
          .map<ShopAudienceEntity>((e) => ShopAudienceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      quickLinks: ((json['quick_links'] as List<dynamic>?) ?? []).map((e) => e.toString()).toList(),
      categories: ((json['categories'] as List<dynamic>?) ?? [])
          .map<ShopCategoryEntity>((e) => ShopCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      editorial: ShopEditorialModel.fromJson((json['editorial'] as Map<String, dynamic>?) ?? {}),
      newInProducts: ((json['new_in_products'] as List<dynamic>?) ?? [])
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      saleBanner: ShopSaleBannerModel.fromJson((json['sale_banner'] as Map<String, dynamic>?) ?? {}),
      brands: ((json['brands'] as List<dynamic>?) ?? [])
          .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
