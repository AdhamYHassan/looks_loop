import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/shop/domain/entities/category_detail_entity.dart';

class CategoryDetailArgs extends Equatable {
  final String id;
  final String title;
  final String slug;
  final List<SubCategoryEntity> subcategories;
  final List<ProductEntity> railProducts;

  const CategoryDetailArgs({
    required this.id,
    required this.title,
    this.slug = '',
    required this.subcategories,
    required this.railProducts,
  });

  @override
  List<Object?> get props => [id, title, slug, subcategories, railProducts];
}
