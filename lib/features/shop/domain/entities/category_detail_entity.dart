import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';

class SubCategoryEntity extends Equatable {
  final String id;
  final String name;
  final int productCount;
  final String imageUrl;

  const SubCategoryEntity({
    required this.id,
    required this.name,
    required this.productCount,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, productCount, imageUrl];
}

class CategoryDetailEntity extends Equatable {
  final String audienceId;
  final String audienceTitle;
  final int totalProductCount;
  final List<SubCategoryEntity> subcategories;
  final ShopEditorialEntity editorial;
  final List<ProductEntity> railProducts;

  const CategoryDetailEntity({
    required this.audienceId,
    required this.audienceTitle,
    required this.totalProductCount,
    required this.subcategories,
    required this.editorial,
    required this.railProducts,
  });

  @override
  List<Object?> get props => [
        audienceId,
        audienceTitle,
        totalProductCount,
        subcategories,
        editorial,
        railProducts,
      ];
}
