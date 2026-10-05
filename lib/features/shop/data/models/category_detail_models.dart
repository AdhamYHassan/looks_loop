import 'package:looks_loop/features/home/data/models/home_feed_models.dart';
import 'package:looks_loop/features/shop/data/models/shop_feed_models.dart';
import 'package:looks_loop/features/shop/domain/entities/category_detail_entity.dart';

class SubCategoryModel extends SubCategoryEntity {
  const SubCategoryModel({
    required super.id,
    required super.name,
    required super.productCount,
    required super.imageUrl,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
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

class CategoryDetailModel extends CategoryDetailEntity {
  const CategoryDetailModel({
    required super.audienceId,
    required super.audienceTitle,
    required super.totalProductCount,
    required super.subcategories,
    required super.editorial,
    required super.railProducts,
  });

  factory CategoryDetailModel.fromJson(Map<String, dynamic> json) {
    final subcatsJson = json['subcategories'] as List<dynamic>? ?? [];
    final railJson = json['rail_products'] as List<dynamic>? ?? [];

    return CategoryDetailModel(
      audienceId: json['audience_id'] as String? ?? '',
      audienceTitle: json['audience_title'] as String? ?? '',
      totalProductCount: (json['total_product_count'] as num?)?.toInt() ?? 0,
      subcategories: subcatsJson
          .map((e) => SubCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      editorial: json['editorial'] != null
          ? ShopEditorialModel.fromJson(
              json['editorial'] as Map<String, dynamic>,
            )
          : const ShopEditorialModel(
              eyebrow: '',
              titleLine1: '',
              titleLine2: '',
              ctaText: '',
              imageUrl: '',
            ),
      railProducts: railJson
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
