import 'package:dio/dio.dart';
import 'package:looks_loop/core/network/api_endpoints.dart';
import 'package:looks_loop/features/search/data/models/search_response_model.dart';

abstract interface class SearchRemoteDataSource {
  Future<SearchResponseModel> search({
    required String query,
    CancelToken? cancelToken,
  });
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final Dio _dio;

  const SearchRemoteDataSourceImpl(this._dio);

  @override
  Future<SearchResponseModel> search({
    required String query,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get(
      ApiEndpoints.search,
      queryParameters: {'q': query},
      cancelToken: cancelToken,
    );
    return SearchResponseModel.fromJson(response.data as Map<String, dynamic>);
  }
}
