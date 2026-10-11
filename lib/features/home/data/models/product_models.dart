import 'package:looks_loop/features/home/domain/entities/product_entities.dart';

class ProductBrandModel extends ProductBrandEntity {
  const ProductBrandModel({
    required super.id,
    required super.name,
    required super.slug,
  });

  factory ProductBrandModel.fromJson(Map<String, dynamic> json) {
    return ProductBrandModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
    );
  }
}

class ProductColorModel extends ProductColorEntity {
  const ProductColorModel({
    required super.id,
    required super.name,
    required super.hex,
  });

  factory ProductColorModel.fromJson(Map<String, dynamic> json) {
    return ProductColorModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      hex: json['hex'] as String? ?? '',
    );
  }
}

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    super.slug,
    required super.name,
    required super.brand,
    super.category,
    super.subcategory,
    required super.price,
    super.originalPrice,
    super.discountPercent,
    super.isOnSale,
    super.isNew,
    required super.imageUrl,
    super.colors,
    super.ratingAverage,
    super.ratingCount,
    super.isWishlisted,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rawBrand = json['brand'];
    final brandName = rawBrand is Map<String, dynamic>
        ? (rawBrand['name'] as String? ?? '')
        : (rawBrand is String ? rawBrand : (json['brand_name'] as String? ?? ''));

    final rawPrice = json['price'];
    final price = _parseDouble(rawPrice);

    final rawOriginalPrice = json['original_price'];
    final originalPrice = rawOriginalPrice != null ? _parseDouble(rawOriginalPrice) : null;

    final rawColors = json['colors'] as List<dynamic>? ?? const [];
    final colors = rawColors
        .whereType<Map<String, dynamic>>()
        .map(ProductColorModel.fromJson)
        .toList();

    final rawRating = json['rating_average'];
    final ratingAverage = _parseDouble(rawRating);

    final rawId = json['id'];
    final idStr = rawId?.toString() ?? '';

    return ProductModel(
      id: idStr,
      slug: json['slug'] as String? ?? '',
      name: json['name'] as String? ?? '',
      brand: brandName,
      category: json['category'] as String? ?? '',
      subcategory: json['subcategory'] as String? ?? '',
      price: price,
      originalPrice: originalPrice,
      discountPercent: json['discount_percentage'] as int? ?? (json['discount_percent'] as int? ?? 0),
      isOnSale: json['is_on_sale'] as bool? ?? false,
      isNew: json['is_new'] as bool? ?? false,
      imageUrl: json['image'] as String? ?? (json['image_url'] as String? ?? ''),
      colors: colors,
      ratingAverage: ratingAverage,
      ratingCount: json['rating_count'] as int? ?? 0,
      isWishlisted: json['is_wishlisted'] as bool? ?? false,
    );
  }

  static double _parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
