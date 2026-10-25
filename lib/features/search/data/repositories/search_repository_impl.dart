import 'package:dio/dio.dart';
import 'package:looks_loop/core/network/network_exceptions.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/search/data/datasources/search_remote_data_source.dart';
import 'package:looks_loop/features/search/domain/entities/search_result_entity.dart';
import 'package:looks_loop/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource _remoteDataSource;

  const SearchRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<SearchResultEntity>> search({
    required String query,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await _remoteDataSource.search(
        query: query,
        cancelToken: cancelToken,
      );
      return ApiSuccess(result);
    } catch (e) {
      if (e is DioException && CancelToken.isCancel(e)) {
        return const ApiSuccess(SearchResultEntity());
      }
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }
}
