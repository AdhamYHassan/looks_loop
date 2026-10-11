import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';
import 'package:looks_loop/features/home/domain/repositories/home_repository.dart';
import 'package:looks_loop/features/home/domain/usecases/get_home_feed_usecase.dart';

class FakeHomeRepository implements HomeRepository {
  final ApiResult<HomeFeedData> result;

  const FakeHomeRepository(this.result);

  @override
  Future<ApiResult<HomeFeedData>> getHomeFeed() async => result;
}

void main() {
  const dummyFeedData = HomeFeedData(
    heroSlides: [],
    announcements: ['NEW DROPS'],
    categories: [],
    newInProducts: [],
    trendingProducts: [],
    featuredLoops: [],
    brands: [],
  );

  test('GetHomeFeedUseCase should return ApiSuccess when repository succeeds',
      () async {
    const repository = FakeHomeRepository(ApiSuccess(dummyFeedData));
    final useCase = GetHomeFeedUseCase(repository);

    final result = await useCase();

    expect(result, isA<ApiSuccess<HomeFeedData>>());
    expect((result as ApiSuccess<HomeFeedData>).data, equals(dummyFeedData));
  });
}
