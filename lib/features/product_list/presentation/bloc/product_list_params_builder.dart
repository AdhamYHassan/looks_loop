import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';
import 'package:looks_loop/features/product_list/domain/repositories/product_list_repository.dart';

class ProductListParamsBuilder {
  ProductListParamsBuilder._();

  static GetProductsParams build({
    required String category,
    required String subcategory,
    required int page,
    required String sort,
    required SelectedFiltersEntity filters,
    String? q,
    bool trending = false,
  }) {
    return GetProductsParams(
      category: category,
      subcategory: subcategory,
      page: page,
      sort: sort,
      q: q,
      brands: filters.brands,
      sizes: filters.sizes,
      colors: filters.colors,
      sale: filters.sale,
      newIn: filters.newIn,
      trending: trending ? true : null,
    );
  }
}
