import 'package:looks_loop/features/home/data/models/product_models.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/product_detail/data/models/product_image_model.dart';
import 'package:looks_loop/features/product_detail/data/models/product_size_model.dart';
import 'package:looks_loop/features/product_detail/data/models/product_variant_model.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:looks_loop/features/product_detail/domain/entities/rating_distribution_entity.dart';

class ProductDetailModel extends ProductDetailEntity {
  const ProductDetailModel({
    required super.id,
    required super.slug,
    required super.name,
    required super.brand,
    super.category,
    super.subcategory,
    required super.price,
    super.originalPrice,
    super.discountPercentage,
    super.isOnSale,
    super.isNew,
    super.sku,
    required super.description,
    required super.materialCare,
    required super.sizeFit,
    super.inStock,
    super.ratingAverage,
    super.ratingCount,
    super.isWishlisted,
    required super.colors,
    required super.sizes,
    required super.variants,
    required super.images,
    super.ratingDistribution,
    super.reviews,
    super.related,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    final rawBrand = json['brand'];
    final brandName = rawBrand is Map<String, dynamic>
        ? (rawBrand['name'] as String? ?? '')
        : (rawBrand is String ? rawBrand : '');

    final colorsList = (json['colors'] as List<dynamic>? ?? [])
        .map((c) {
          final m = c as Map<String, dynamic>;
          final rawHex = (m['hex'] as String? ?? '').replaceAll('#', '').trim();
          final hex = rawHex.length == 6 ? '0xFF$rawHex' : '0xFF1A1A1A';
          return ProductColorEntity(
            id: m['id'] as int? ?? 0,
            name: m['name'] as String? ?? '',
            hex: hex,
          );
        })
        .toList();

    final sizesList = (json['sizes'] as List<dynamic>? ?? [])
        .map((s) => ProductSizeModel.fromJson(s as Map<String, dynamic>))
        .toList();

    final variantsList = (json['variants'] as List<dynamic>? ?? [])
        .map((v) => ProductVariantModel.fromJson(v as Map<String, dynamic>))
        .toList();

    var imagesList = (json['images'] as List<dynamic>? ?? [])
        .map((img) => ProductImageModel.fromJson(img as Map<String, dynamic>))
        .toList();
    if (imagesList.isEmpty && (json['image'] as String? ?? '').isNotEmpty) {
      imagesList = [
        ProductImageModel(
          id: 0,
          url: json['image'] as String,
          isPrimary: true,
        ),
      ];
    }

    final rawDist = json['rating_distribution'];
    final distList = <RatingDistributionEntity>[];
    if (rawDist is Map<String, dynamic>) {
      var total = 0;
      for (var i = 1; i <= 5; i++) {
        total += (rawDist[i.toString()] as num? ?? 0).toInt();
      }
      for (var i = 5; i >= 1; i--) {
        final count = (rawDist[i.toString()] as num? ?? 0).toInt();
        distList.add(RatingDistributionEntity(
          star: i,
          count: count,
          percentage: total > 0 ? count / total : 0.0,
        ));
      }
    }

    final relatedList = (json['related'] as List<dynamic>? ?? [])
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return ProductDetailModel(
      id: json['id'] as int? ?? 0,
      slug: json['slug'] as String? ?? '',
      name: json['name'] as String? ?? '',
      brand: brandName,
      category: json['category'] as String? ?? '',
      subcategory: json['subcategory'] as String? ?? '',
      price: double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
      originalPrice: json['original_price'] != null
          ? double.tryParse(json['original_price'].toString())
          : null,
      discountPercentage: json['discount_percentage'] as int? ?? 0,
      isOnSale: json['is_on_sale'] as bool? ?? false,
      isNew: json['is_new'] as bool? ?? false,
      sku: json['sku'] as String? ?? '',
      description: json['description'] as String? ?? '',
      materialCare: json['material_care'] as String? ?? '',
      sizeFit: json['size_fit'] as String? ?? '',
      inStock: json['in_stock'] as bool? ?? true,
      ratingAverage: double.tryParse(json['rating_average']?.toString() ?? '') ?? 0.0,
      ratingCount: json['rating_count'] as int? ?? 0,
      isWishlisted: json['is_wishlisted'] as bool? ?? false,
      colors: colorsList,
      sizes: sizesList,
      variants: variantsList,
      images: imagesList,
      ratingDistribution: distList,
      related: relatedList,
    );
  }
}
