import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';
import 'package:looks_loop/features/product_list/domain/usecases/get_products_usecase.dart';
import 'package:looks_loop/features/product_list/presentation/bloc/product_list_params_builder.dart';
import 'package:looks_loop/features/product_list/presentation/bloc/product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final GetProductsUseCase _getProductsUseCase;

  ProductListCubit(this._getProductsUseCase)
      : super(const ProductListInitial());

  Future<void> loadProducts({
    required String category,
    required String subcategory,
    String? sort,
    String? q,
    SelectedFiltersEntity? filters,
    bool trending = false,
  }) async {
    emit(const ProductListLoading());

    final selected = filters ?? const SelectedFiltersEntity();
    final effectiveSort = sort ?? 'recommended';
    final params = ProductListParamsBuilder.build(
      category: category,
      subcategory: subcategory,
      page: 1,
      sort: effectiveSort,
      q: q,
      filters: selected,
      trending: trending,
    );

    final result = await _getProductsUseCase(params);
    switch (result) {
      case ApiSuccess(:final data):
        emit(ProductListLoaded(
          data: data,
          category: category,
          subcategory: subcategory,
          searchQuery: q,
          currentSort: effectiveSort,
          currentFilters: selected,
          isTrending: trending,
          hasReachedMax: data.page >= data.numPages,
        ));
      case ApiFailure(:final failure):
        emit(ProductListError(failure.message));
    }
  }

  Future<void> loadMore() async {
    final curr = state;
    if (curr is! ProductListLoaded || curr.isLoadingMore || curr.hasReachedMax) return;

    emit(curr.copyWith(isLoadingMore: true));
    final nextPage = curr.data.page + 1;
    final params = ProductListParamsBuilder.build(
      category: curr.category,
      subcategory: curr.subcategory,
      page: nextPage,
      sort: curr.currentSort,
      q: curr.searchQuery,
      filters: curr.currentFilters,
      trending: curr.isTrending,
    );

    final result = await _getProductsUseCase(params);
    if (isClosed) return;

    switch (result) {
      case ApiSuccess(:final data):
        final updatedData = ProductListEntity(
          count: data.count,
          page: data.page,
          numPages: data.numPages,
          nextPage: data.nextPage,
          sort: data.sort,
          sortOptions: data.sortOptions.isNotEmpty ? data.sortOptions : curr.data.sortOptions,
          selected: data.selected,
          facets: data.facets,
          results: [...curr.data.results, ...data.results],
        );
        emit(curr.copyWith(
          data: updatedData,
          isLoadingMore: false,
          hasReachedMax: data.page >= data.numPages,
        ));
      case ApiFailure():
        emit(curr.copyWith(isLoadingMore: false));
    }
  }

  void _reload({
    String? category,
    String? subcategory,
    String? sort,
    String? q,
    SelectedFiltersEntity? filters,
  }) {
    final curr = state;
    if (curr is! ProductListLoaded) return;
    loadProducts(
      category: category ?? curr.category,
      subcategory: subcategory ?? curr.subcategory,
      sort: sort ?? curr.currentSort,
      q: q ?? curr.searchQuery,
      filters: filters ?? curr.currentFilters,
      trending: curr.isTrending,
    );
  }

  void changeSort(String newSort) => _reload(sort: newSort);

  void applyFilters(SelectedFiltersEntity newFilters) => _reload(filters: newFilters);

  void filterByCategory(String newCategorySlug) =>
      _reload(category: newCategorySlug, subcategory: '');

  void search(String query) => _reload(q: query);

  void clearAllFilters() => applyFilters(const SelectedFiltersEntity());
}
