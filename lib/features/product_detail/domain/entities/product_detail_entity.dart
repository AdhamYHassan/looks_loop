import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_image_entity.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_review_entity.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_size_entity.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_variant_entity.dart';
import 'package:looks_loop/features/product_detail/domain/entities/rating_distribution_entity.dart';

class ProductDetailEntity extends Equatable {
  final int id;
  final String slug;
  final String name;
  final String brand;
  final String category;
  final String subcategory;
  final double price;
  final double? originalPrice;
  final int discountPercentage;
  final bool isOnSale;
  final bool isNew;
  final String sku;
  final String description;
  final String materialCare;
  final String sizeFit;
  final bool inStock;
  final double ratingAverage;
  final int ratingCount;
  final bool isWishlisted;
  final List<ProductColorEntity> colors;
  final List<ProductSizeEntity> sizes;
  final List<ProductVariantEntity> variants;
  final List<ProductImageEntity> images;
  final List<RatingDistributionEntity> ratingDistribution;
  final List<ProductReviewEntity> reviews;
  final List<ProductEntity> related;

  const ProductDetailEntity({
    required this.id,
    required this.slug,
    required this.name,
    required this.brand,
    this.category = '',
    this.subcategory = '',
    required this.price,
    this.originalPrice,
    this.discountPercentage = 0,
    this.isOnSale = false,
    this.isNew = false,
    this.sku = '',
    required this.description,
    required this.materialCare,
    required this.sizeFit,
    this.inStock = true,
    this.ratingAverage = 0.0,
    this.ratingCount = 0,
    this.isWishlisted = false,
    required this.colors,
    required this.sizes,
    required this.variants,
    required this.images,
    this.ratingDistribution = const [],
    this.reviews = const [],
    this.related = const [],
  });

  bool isSizeAvailableForColor({required int sizeId, required int colorId}) {
    for (final variant in variants) {
      if (variant.colorId == colorId && variant.sizeId == sizeId) {
        return variant.isAvailable && variant.stock > 0;
      }
    }
    return false;
  }

  ProductVariantEntity? getVariant({required int sizeId, required int colorId}) {
    for (final variant in variants) {
      if (variant.colorId == colorId && variant.sizeId == sizeId) {
        return variant;
      }
    }
    return null;
  }

  ProductSizeEntity? findDefaultSize(int? colorId) {
    if (colorId == null) return sizes.firstOrNull;
    for (final s in sizes) {
      if (isSizeAvailableForColor(sizeId: s.id, colorId: colorId)) return s;
    }
    return sizes.firstOrNull;
  }

  ProductEntity toProductEntity() {
    final primaryImg = images.firstWhere(
      (img) => img.isPrimary,
      orElse: () => images.isNotEmpty
          ? images.first
          : const ProductImageEntity(id: 0, url: '', isPrimary: false),
    );
    return ProductEntity(
      id: id.toString(),
      slug: slug,
      name: name,
      brand: brand,
      category: category,
      subcategory: subcategory,
      price: price,
      originalPrice: originalPrice,
      discountPercent: discountPercentage,
      isOnSale: isOnSale,
      isNew: isNew,
      imageUrl: primaryImg.url,
      colors: colors,
      ratingAverage: ratingAverage,
      ratingCount: ratingCount,
      isWishlisted: isWishlisted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        slug,
        name,
        brand,
        category,
        subcategory,
        price,
        originalPrice,
        discountPercentage,
        isOnSale,
        isNew,
        sku,
        description,
        materialCare,
        sizeFit,
        inStock,
        ratingAverage,
        ratingCount,
        isWishlisted,
        colors,
        sizes,
        variants,
        images,
        ratingDistribution,
        reviews,
        related,
      ];
}
