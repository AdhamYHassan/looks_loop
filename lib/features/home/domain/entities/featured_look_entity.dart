import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';

class LookHotspotEntity extends Equatable {
  final double x;
  final double y;
  final ProductEntity product;

  const LookHotspotEntity({
    required this.x,
    required this.y,
    required this.product,
  });

  @override
  List<Object?> get props => [x, y, product];
}

class FeaturedLookEntity extends Equatable {
  final int id;
  final String slug;
  final String title;
  final String description;
  final String imageUrl;
  final bool isFeatured;
  final List<LookHotspotEntity> hotspots;

  const FeaturedLookEntity({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.isFeatured = true,
    this.hotspots = const [],
  });

  @override
  List<Object?> get props => [
        id,
        slug,
        title,
        description,
        imageUrl,
        isFeatured,
        hotspots,
      ];
}
