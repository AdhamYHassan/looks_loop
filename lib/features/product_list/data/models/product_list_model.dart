import 'package:looks_loop/features/home/data/models/product_models.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';

class SortOptionModel extends SortOptionEntity {
  const SortOptionModel({required super.value, required super.label});

  factory SortOptionModel.fromJson(Map<String, dynamic> json) {
    return SortOptionModel(
      value: json['value'] as String? ?? '',
      label: json['label'] as String? ?? '',
    );
  }
}

class BrandFacetModel extends BrandFacetEntity {
  const BrandFacetModel({
    required super.slug,
    required super.name,
    required super.count,
  });

  factory BrandFacetModel.fromJson(Map<String, dynamic> json) {
    return BrandFacetModel(
      slug: json['slug'] as String? ?? '',
      name: json['name'] as String? ?? '',
      count: json['count'] as int? ?? 0,
    );
  }
}

class ProductListFacetsModel extends ProductListFacetsEntity {
  const ProductListFacetsModel({
    super.brands,
    super.sizes,
    super.colors,
  });

  factory ProductListFacetsModel.fromJson(Map<String, dynamic> json) {
    final rawBrands = json['brands'] as List<dynamic>? ?? [];
    final brands = rawBrands
        .whereType<Map<String, dynamic>>()
        .map(BrandFacetModel.fromJson)
        .toList();

    final rawSizes = json['sizes'] as List<dynamic>? ?? [];
    final sizes = rawSizes.map((e) => e.toString()).toList();

    final rawColors = json['colors'] as List<dynamic>? ?? [];
    final colors = rawColors.map((e) => e.toString()).toList();

    return ProductListFacetsModel(
      brands: brands,
      sizes: sizes,
      colors: colors,
    );
  }
}

class SelectedFiltersModel extends SelectedFiltersEntity {
  const SelectedFiltersModel({
    super.brands,
    super.sizes,
    super.colors,
    super.sale,
    super.newIn,
  });

  factory SelectedFiltersModel.fromJson(Map<String, dynamic> json) {
    final rawBrands = json['brands'] as List<dynamic>? ?? [];
    final rawSizes = json['sizes'] as List<dynamic>? ?? [];
    final rawColors = json['colors'] as List<dynamic>? ?? [];

    return SelectedFiltersModel(
      brands: rawBrands.map((e) => e.toString()).toList(),
      sizes: rawSizes.map((e) => e.toString()).toList(),
      colors: rawColors.map((e) => e.toString()).toList(),
      sale: json['sale'] as bool? ?? false,
      newIn: json['new'] as bool? ?? false,
    );
  }
}

class ProductListModel extends ProductListEntity {
  const ProductListModel({
    required super.count,
    required super.page,
    required super.numPages,
    super.nextPage,
    required super.sort,
    required super.sortOptions,
    required super.selected,
    required super.facets,
    required super.results,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final sortOptionsList = (data['sort_options'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(SortOptionModel.fromJson)
        .toList();

    final facetsObj = data['facets'] is Map<String, dynamic>
        ? ProductListFacetsModel.fromJson(
            data['facets'] as Map<String, dynamic>,
          )
        : const ProductListFacetsModel();

    final selectedObj = data['selected'] is Map<String, dynamic>
        ? SelectedFiltersModel.fromJson(
            data['selected'] as Map<String, dynamic>,
          )
        : const SelectedFiltersModel();

    final resultsList = (data['results'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(ProductModel.fromJson)
        .toList();

    return ProductListModel(
      count: data['count'] as int? ?? resultsList.length,
      page: data['page'] as int? ?? 1,
      numPages: data['num_pages'] as int? ?? 1,
      nextPage: data['next_page'] as int?,
      sort: data['sort'] as String? ?? 'recommended',
      sortOptions: sortOptionsList,
      selected: selectedObj,
      facets: facetsObj,
      results: resultsList,
    );
  }
}
