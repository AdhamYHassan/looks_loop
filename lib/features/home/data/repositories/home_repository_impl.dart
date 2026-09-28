import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/data/datasources/home_remote_data_source.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  const HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<HomeFeedData>> getHomeFeed() async {
    try {
      final feedModel = await _remoteDataSource.getHomeFeed();
      return ApiSuccess(feedModel);
    } on FormatException catch (e) {
      return ApiFailure(ServerFailure('Invalid data format: ${e.message}'));
    } catch (e) {
      return ApiFailure(UnknownFailure(e.toString()));
    }
  }
}
