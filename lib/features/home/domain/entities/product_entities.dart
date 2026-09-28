import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String brand;
  final String name;
  final double price;
  final double? originalPrice;
  final int? discountPercent;
  final String imageUrl;
  final bool isWishlisted;

  const ProductEntity({
    required this.id,
    required this.brand,
    required this.name,
    required this.price,
    this.originalPrice,
    this.discountPercent,
    required this.imageUrl,
    this.isWishlisted = false,
  });

  @override
  List<Object?> get props => [
        id,
        brand,
        name,
        price,
        originalPrice,
        discountPercent,
        imageUrl,
        isWishlisted,
      ];
}

class TrendingItemEntity extends Equatable {
  final String id;
  final String brand;
  final String name;
  final double price;
  final String imageUrl;

  const TrendingItemEntity({
    required this.id,
    required this.brand,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, brand, name, price, imageUrl];
}

class CuratedLookEntity extends Equatable {
  final String id;
  final String eyebrow;
  final String title;
  final String piecesLabel;
  final String imageUrl;
  final String ctaText;

  const CuratedLookEntity({
    required this.id,
    required this.eyebrow,
    required this.title,
    required this.piecesLabel,
    required this.imageUrl,
    required this.ctaText,
  });

  @override
  List<Object?> get props => [id, eyebrow, title, piecesLabel, imageUrl, ctaText];
}

class MotionReelEntity extends Equatable {
  final String id;
  final String title;
  final String views;
  final String thumbnailUrl;

  const MotionReelEntity({
    required this.id,
    required this.title,
    required this.views,
    required this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [id, title, views, thumbnailUrl];
}
