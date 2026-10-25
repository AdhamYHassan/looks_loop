import 'package:dio/dio.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/search/domain/entities/search_result_entity.dart';

abstract interface class SearchRepository {
  Future<ApiResult<SearchResultEntity>> search({
    required String query,
    CancelToken? cancelToken,
  });
}
