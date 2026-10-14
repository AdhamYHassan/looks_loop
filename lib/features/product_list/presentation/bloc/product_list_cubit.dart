import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';
import 'package:looks_loop/features/product_list/domain/repositories/product_list_repository.dart';
import 'package:looks_loop/features/product_list/domain/usecases/get_products_usecase.dart';
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
  }) async {
    emit(const ProductListLoading());

    final selected = filters ?? const SelectedFiltersEntity();
    final effectiveSort = sort ?? 'recommended';

    final params = GetProductsParams(
      category: category,
      subcategory: subcategory,
      page: 1,
      sort: effectiveSort,
      q: q,
      brands: selected.brands,
      sizes: selected.sizes,
      colors: selected.colors,
      sale: selected.sale,
      newIn: selected.newIn,
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
          hasReachedMax: data.page >= data.numPages,
        ));
      case ApiFailure(:final failure):
        emit(ProductListError(failure.message));
    }
  }

  Future<void> loadMore() async {
    final curr = state;
    if (curr is! ProductListLoaded || curr.isLoadingMore || curr.hasReachedMax) {
      return;
    }

    emit(curr.copyWith(isLoadingMore: true));

    final nextPage = curr.data.page + 1;
    final params = GetProductsParams(
      category: curr.category,
      subcategory: curr.subcategory,
      page: nextPage,
      sort: curr.currentSort,
      q: curr.searchQuery,
      brands: curr.currentFilters.brands,
      sizes: curr.currentFilters.sizes,
      colors: curr.currentFilters.colors,
      sale: curr.currentFilters.sale,
      newIn: curr.currentFilters.newIn,
    );

    final result = await _getProductsUseCase(params);

    if (isClosed) return;

    switch (result) {
      case ApiSuccess(:final data):
        final combinedProducts = [...curr.data.results, ...data.results];
        final updatedData = ProductListEntity(
          count: data.count,
          page: data.page,
          numPages: data.numPages,
          nextPage: data.nextPage,
          sort: data.sort,
          sortOptions: data.sortOptions.isNotEmpty ? data.sortOptions : curr.data.sortOptions,
          selected: data.selected,
          facets: data.facets,
          results: combinedProducts,
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

  void changeSort(String newSort) {
    final curr = state;
    if (curr is! ProductListLoaded) return;
    loadProducts(
      category: curr.category,
      subcategory: curr.subcategory,
      sort: newSort,
      q: curr.searchQuery,
      filters: curr.currentFilters,
    );
  }

  void applyFilters(SelectedFiltersEntity newFilters) {
    final curr = state;
    if (curr is! ProductListLoaded) return;
    loadProducts(
      category: curr.category,
      subcategory: curr.subcategory,
      sort: curr.currentSort,
      q: curr.searchQuery,
      filters: newFilters,
    );
  }

  void search(String query) {
    final curr = state;
    if (curr is! ProductListLoaded) return;
    loadProducts(
      category: curr.category,
      subcategory: curr.subcategory,
      sort: curr.currentSort,
      q: query,
      filters: curr.currentFilters,
    );
  }

  void clearAllFilters() {
    final curr = state;
    if (curr is! ProductListLoaded) return;
    applyFilters(const SelectedFiltersEntity());
  }
}
