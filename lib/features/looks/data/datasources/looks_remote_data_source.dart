import 'package:looks_loop/core/network/api_endpoints.dart';
import 'package:looks_loop/core/network/inetwork_helper.dart';
import 'package:looks_loop/features/looks/data/models/look_model.dart';

abstract interface class LooksRemoteDataSource {
  Future<List<LookSummaryModel>> getLooks();
  Future<FeaturedLookModel> getLookDetail(String slug);
}

class LooksRemoteDataSourceImpl implements LooksRemoteDataSource {
  final InetworkHelper _networkHelper;

  const LooksRemoteDataSourceImpl(this._networkHelper);

  @override
  Future<List<LookSummaryModel>> getLooks() async {
    final response = await _networkHelper.get(ApiEndpoints.looks);
    final data = response.data;
    final List<dynamic> list =
        data is Map<String, dynamic> && data['data'] is List
            ? data['data'] as List<dynamic>
            : (data is List ? data : const []);

    return list
        .whereType<Map<String, dynamic>>()
        .map(LookSummaryModel.fromJson)
        .toList();
  }

  @override
  Future<FeaturedLookModel> getLookDetail(String slug) async {
    final response = await _networkHelper.get(ApiEndpoints.lookDetail(slug));
    final data = response.data;
    final root =
        data is Map<String, dynamic> && data['data'] is Map<String, dynamic>
            ? data['data'] as Map<String, dynamic>
            : (data is Map<String, dynamic> ? data : const <String, dynamic>{});

    return FeaturedLookModel.fromJson(root);
  }
}
