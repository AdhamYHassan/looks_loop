import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/domain/repositories/home_repository.dart';

class GetHomeFeedUseCase {
  final HomeRepository _repository;

  const GetHomeFeedUseCase(this._repository);

  Future<ApiResult<HomeFeedData>> call() async {
    return await _repository.getHomeFeed();
  }
}
