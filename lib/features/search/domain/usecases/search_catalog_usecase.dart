import 'package:dio/dio.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/search/domain/entities/search_result_entity.dart';
import 'package:looks_loop/features/search/domain/repositories/search_repository.dart';

class SearchCatalogUseCase {
  final SearchRepository _repository;

  const SearchCatalogUseCase(this._repository);

  Future<ApiResult<SearchResultEntity>> call({
    required String query,
    CancelToken? cancelToken,
  }) {
    final sanitizedQuery = query.trim();
    if (sanitizedQuery.isEmpty) {
      return Future.value(const ApiSuccess(SearchResultEntity()));
    }
    return _repository.search(
      query: sanitizedQuery,
      cancelToken: cancelToken,
    );
  }
}
