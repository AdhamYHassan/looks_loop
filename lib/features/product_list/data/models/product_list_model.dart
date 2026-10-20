import 'package:looks_loop/features/home/data/models/product_models.dart';
import 'package:looks_loop/features/product_list/data/models/product_facet_models.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';

export 'package:looks_loop/features/product_list/data/models/product_facet_models.dart';

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
