import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/search/domain/usecases/search_catalog_usecase.dart';
import 'package:looks_loop/features/search/presentation/bloc/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchCatalogUseCase _searchCatalogUseCase;
  Timer? _debounceTimer;
  CancelToken? _cancelToken;

  SearchCubit(this._searchCatalogUseCase) : super(const SearchInitial());

  void onQueryChanged(String rawQuery) {
    _debounceTimer?.cancel();
    final query = rawQuery.trim();

    if (query.length < 2) {
      _cancelActiveRequest();
      emit(const SearchInitial());
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 350), () {
      _executeSearch(query);
    });
  }

  Future<void> _executeSearch(String query) async {
    _cancelActiveRequest();
    _cancelToken = CancelToken();

    emit(SearchLoading(query: query));

    final result = await _searchCatalogUseCase(
      query: query,
      cancelToken: _cancelToken,
    );

    if (isClosed) return;

    switch (result) {
      case ApiSuccess(:final data):
        if (data.isEmpty) {
          emit(SearchEmpty(query: query));
        } else {
          emit(SearchLoaded(query: query, results: data));
        }
      case ApiFailure(:final failure):
        emit(SearchError(message: failure.message));
    }
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    _cancelActiveRequest();
    emit(const SearchInitial());
  }

  void _cancelActiveRequest() {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel('Request superseded by new search query');
    }
    _cancelToken = null;
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    _cancelActiveRequest();
    return super.close();
  }
}
