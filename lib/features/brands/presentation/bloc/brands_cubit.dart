import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/brands/domain/entities/brand_entity.dart';
import 'package:looks_loop/features/brands/domain/entities/get_brands_params.dart';
import 'package:looks_loop/features/brands/domain/usecases/get_brands_usecase.dart';
import 'package:looks_loop/features/brands/presentation/bloc/brands_state.dart';

class BrandsCubit extends Cubit<BrandsState> {
  final GetBrandsUseCase _getBrandsUseCase;
  Timer? _debounceTimer;
  String? _category;

  BrandsCubit(this._getBrandsUseCase) : super(const BrandsInitial());

  Future<void> loadBrands({String? category}) async {
    _category = category;
    emit(const BrandsLoading());

    final result = await _getBrandsUseCase(GetBrandsParams(category: category));

    switch (result) {
      case ApiSuccess(:final data):
        emit(_buildLoadedState(brands: data, query: ''));
      case ApiFailure(:final failure):
        emit(BrandsError(failure.message));
    }
  }

  void searchBrands(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 350), () async {
      await _executeSearch(query.trim());
    });
  }

  Future<void> _executeSearch(String query) async {
    final current = state;
    if (current is BrandsLoaded) {
      emit(current.copyWith(isSearching: true, searchQuery: query));
    }

    final params = GetBrandsParams(
      category: _category,
      q: query.isEmpty ? null : query,
    );

    final result = await _getBrandsUseCase(params);

    switch (result) {
      case ApiSuccess(:final data):
        emit(_buildLoadedState(brands: data, query: query));
      case ApiFailure(:final failure):
        emit(BrandsError(failure.message));
    }
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    _executeSearch('');
  }

  BrandsLoaded _buildLoadedState({
    required List<BrandEntity> brands,
    required String query,
  }) {
    final sorted = List<BrandEntity>.from(brands)
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    final featured = sorted.where((b) => b.isFeatured).toList();

    final azMap = <String, List<BrandEntity>>{};
    for (final brand in sorted) {
      final firstLetter = brand.name.trim().isNotEmpty
          ? brand.name.trim()[0].toUpperCase()
          : '#';
      azMap.putIfAbsent(firstLetter, () => []).add(brand);
    }

    return BrandsLoaded(
      allBrands: sorted,
      featuredBrands: featured,
      azBrands: azMap,
      searchQuery: query,
      isSearching: false,
    );
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
