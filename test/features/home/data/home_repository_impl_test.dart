import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/data/datasources/home_remote_data_source.dart';
import 'package:looks_loop/features/home/data/models/home_feed_models.dart';
import 'package:looks_loop/features/home/data/repositories/home_repository_impl.dart';
import 'package:looks_loop/features/home/domain/entities/home_feed_entities.dart';

class MockSuccessDataSource implements HomeRemoteDataSource {
  @override
  Future<HomeFeedModel> getHomeFeed() async {
    return const HomeFeedModel(
      heroSlides: [],
      categories: [],
      newInProducts: [],
      trendingItems: [],
      curatedLook: CuratedLookModel(
        id: '1',
        eyebrow: 'E',
        title: 'T',
        piecesLabel: 'P',
        imageUrl: 'I',
        ctaText: 'C',
      ),
      motionReels: [],
      brands: [],
    );
  }
}

class MockFailureDataSource implements HomeRemoteDataSource {
  @override
  Future<HomeFeedModel> getHomeFeed() async {
    throw Exception('Server unreachable');
  }
}

void main() {
  test('HomeRepositoryImpl returns ApiSuccess when remote data source succeeds',
      () async {
    final repo = HomeRepositoryImpl(MockSuccessDataSource());
    final result = await repo.getHomeFeed();

    expect(result, isA<ApiSuccess<HomeFeedData>>());
  });

  test('HomeRepositoryImpl catches exceptions and returns ApiFailure',
      () async {
    final repo = HomeRepositoryImpl(MockFailureDataSource());
    final result = await repo.getHomeFeed();

    expect(result, isA<ApiFailure<HomeFeedData>>());
    expect((result as ApiFailure<HomeFeedData>).failure, isA<UnknownFailure>());
  });
}
