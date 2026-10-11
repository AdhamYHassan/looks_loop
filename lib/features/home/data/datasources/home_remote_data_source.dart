import 'package:looks_loop/core/network/api_endpoints.dart';
import 'package:looks_loop/core/network/inetwork_helper.dart';
import 'package:looks_loop/features/home/data/models/home_feed_models.dart';

abstract interface class HomeRemoteDataSource {
  Future<HomeFeedModel> getHomeFeed();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final InetworkHelper _networkHelper;

  const HomeRemoteDataSourceImpl(this._networkHelper);

  @override
  Future<HomeFeedModel> getHomeFeed() async {
    final response = await _networkHelper.get(ApiEndpoints.home);
    return HomeFeedModel.fromJson(response.data as Map<String, dynamic>);
  }
}
