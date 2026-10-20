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

  GetProductsParams _buildParams({
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
    final params = _buildParams(
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
    if (curr is! ProductListLoaded || curr.isLoadingMore || curr.hasReachedMax) {
      return;
    }

    emit(curr.copyWith(isLoadingMore: true));

    final nextPage = curr.data.page + 1;
    final params = _buildParams(
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
      trending: curr.isTrending,
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
      trending: curr.isTrending,
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
      trending: curr.isTrending,
    );
  }

  void clearAllFilters() {
    final curr = state;
    if (curr is! ProductListLoaded) return;
    applyFilters(const SelectedFiltersEntity());
  }
}
