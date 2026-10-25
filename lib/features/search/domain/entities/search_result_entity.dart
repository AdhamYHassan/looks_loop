import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';

class SearchBrandEntity extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String? logo;

  const SearchBrandEntity({
    required this.id,
    required this.name,
    required this.slug,
    this.logo,
  });

  @override
  List<Object?> get props => [id, name, slug, logo];
}

class SearchCategoryEntity extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String? image;

  const SearchCategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, slug, image];
}

class SearchResultEntity extends Equatable {
  final List<ProductEntity> products;
  final List<SearchBrandEntity> brands;
  final List<SearchCategoryEntity> categories;

  const SearchResultEntity({
    this.products = const [],
    this.brands = const [],
    this.categories = const [],
  });

  bool get isEmpty => products.isEmpty && brands.isEmpty && categories.isEmpty;
  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [products, brands, categories];
}
