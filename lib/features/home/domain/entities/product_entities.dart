import 'package:equatable/equatable.dart';

class ProductBrandEntity extends Equatable {
  final int id;
  final String name;
  final String slug;

  const ProductBrandEntity({
    required this.id,
    required this.name,
    required this.slug,
  });

  @override
  List<Object?> get props => [id, name, slug];
}

class ProductColorEntity extends Equatable {
  final int id;
  final String name;
  final String hex;

  const ProductColorEntity({
    required this.id,
    required this.name,
    required this.hex,
  });

  @override
  List<Object?> get props => [id, name, hex];
}

class ProductEntity extends Equatable {
  final String id;
  final String slug;
  final String name;
  final String brand;
  final String category;
  final String subcategory;
  final double price;
  final double? originalPrice;
  final int discountPercent;
  final bool isOnSale;
  final bool isNew;
  final String imageUrl;
  final List<ProductColorEntity> colors;
  final double ratingAverage;
  final int ratingCount;
  final bool isWishlisted;

  const ProductEntity({
    required this.id,
    this.slug = '',
    required this.name,
    required this.brand,
    this.category = '',
    this.subcategory = '',
    required this.price,
    this.originalPrice,
    this.discountPercent = 0,
    this.isOnSale = false,
    this.isNew = false,
    required this.imageUrl,
    this.colors = const [],
    this.ratingAverage = 0.0,
    this.ratingCount = 0,
    this.isWishlisted = false,
  });

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
        discountPercent,
        isOnSale,
        isNew,
        imageUrl,
        colors,
        ratingAverage,
        ratingCount,
        isWishlisted,
      ];
}
