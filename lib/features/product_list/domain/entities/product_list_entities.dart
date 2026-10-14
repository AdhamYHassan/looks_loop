import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';

class SortOptionEntity extends Equatable {
  final String value;
  final String label;

  const SortOptionEntity({required this.value, required this.label});

  @override
  List<Object?> get props => [value, label];
}

class BrandFacetEntity extends Equatable {
  final String slug;
  final String name;
  final int count;

  const BrandFacetEntity({
    required this.slug,
    required this.name,
    required this.count,
  });

  @override
  List<Object?> get props => [slug, name, count];
}

class ProductListFacetsEntity extends Equatable {
  final List<BrandFacetEntity> brands;
  final List<String> sizes;
  final List<String> colors;

  const ProductListFacetsEntity({
    this.brands = const [],
    this.sizes = const [],
    this.colors = const [],
  });

  @override
  List<Object?> get props => [brands, sizes, colors];
}

class SelectedFiltersEntity extends Equatable {
  final List<String> brands;
  final List<String> sizes;
  final List<String> colors;
  final bool sale;
  final bool newIn;

  const SelectedFiltersEntity({
    this.brands = const [],
    this.sizes = const [],
    this.colors = const [],
    this.sale = false,
    this.newIn = false,
  });

  int get activeFilterCount {
    var count = brands.length + sizes.length + colors.length;
    if (sale) count += 1;
    if (newIn) count += 1;
    return count;
  }

  SelectedFiltersEntity copyWith({
    List<String>? brands,
    List<String>? sizes,
    List<String>? colors,
    bool? sale,
    bool? newIn,
  }) {
    return SelectedFiltersEntity(
      brands: brands ?? this.brands,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      sale: sale ?? this.sale,
      newIn: newIn ?? this.newIn,
    );
  }

  @override
  List<Object?> get props => [brands, sizes, colors, sale, newIn];
}

class ProductListEntity extends Equatable {
  final int count;
  final int page;
  final int numPages;
  final int? nextPage;
  final String sort;
  final List<SortOptionEntity> sortOptions;
  final SelectedFiltersEntity selected;
  final ProductListFacetsEntity facets;
  final List<ProductEntity> results;

  const ProductListEntity({
    required this.count,
    required this.page,
    required this.numPages,
    this.nextPage,
    required this.sort,
    required this.sortOptions,
    required this.selected,
    required this.facets,
    required this.results,
  });

  @override
  List<Object?> get props => [
        count,
        page,
        numPages,
        nextPage,
        sort,
        sortOptions,
        selected,
        facets,
        results,
      ];
}
