import 'package:looks_loop/features/home/data/datasources/home_mock_data.dart';
import 'package:looks_loop/features/home/data/models/home_feed_models.dart';

abstract class HomeRemoteDataSource {
  Future<HomeFeedModel> getHomeFeed();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl();

  @override
  Future<HomeFeedModel> getHomeFeed() async {
    // Simulating network latency for realistic mobile async behavior
    await Future.delayed(const Duration(milliseconds: 300));
    return kDefaultHomeFeedModel;
  }
}
