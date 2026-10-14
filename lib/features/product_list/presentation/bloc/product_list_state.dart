import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object?> get props => [];
}

class ProductListInitial extends ProductListState {
  const ProductListInitial();
}

class ProductListLoading extends ProductListState {
  const ProductListLoading();
}

class ProductListLoaded extends ProductListState {
  final ProductListEntity data;
  final String category;
  final String subcategory;
  final String? searchQuery;
  final String currentSort;
  final SelectedFiltersEntity currentFilters;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final String? errorMessage;

  const ProductListLoaded({
    required this.data,
    required this.category,
    required this.subcategory,
    this.searchQuery,
    required this.currentSort,
    required this.currentFilters,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.errorMessage,
  });

  ProductListLoaded copyWith({
    ProductListEntity? data,
    String? category,
    String? subcategory,
    ValueGetter<String?>? searchQuery,
    String? currentSort,
    SelectedFiltersEntity? currentFilters,
    bool? isLoadingMore,
    bool? hasReachedMax,
    ValueGetter<String?>? errorMessage,
  }) {
    return ProductListLoaded(
      data: data ?? this.data,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      searchQuery: searchQuery != null ? searchQuery() : this.searchQuery,
      currentSort: currentSort ?? this.currentSort,
      currentFilters: currentFilters ?? this.currentFilters,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        data,
        category,
        subcategory,
        searchQuery,
        currentSort,
        currentFilters,
        isLoadingMore,
        hasReachedMax,
        errorMessage,
      ];
}

class ProductListError extends ProductListState {
  final String message;

  const ProductListError(this.message);

  @override
  List<Object?> get props => [message];
}
