import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';

class FeaturedLoopEntity extends Equatable {
  final int id;
  final String slug;
  final String title;
  final String creator;
  final String thumbnail;
  final String videoUrl;
  final int views;
  final int likesCount;
  final bool liked;
  final List<String> brands;
  final List<ProductEntity> products;

  const FeaturedLoopEntity({
    required this.id,
    required this.slug,
    required this.title,
    required this.creator,
    required this.thumbnail,
    this.videoUrl = '',
    this.views = 0,
    this.likesCount = 0,
    this.liked = false,
    this.brands = const [],
    this.products = const [],
  });

  @override
  List<Object?> get props => [
        id,
        slug,
        title,
        creator,
        thumbnail,
        videoUrl,
        views,
        likesCount,
        liked,
        brands,
        products,
      ];
}
