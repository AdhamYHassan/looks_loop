import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/data/models/featured_look_model.dart';
import 'package:looks_loop/features/looks/data/datasources/looks_remote_data_source.dart';
import 'package:looks_loop/features/looks/data/models/look_model.dart';
import 'package:looks_loop/features/looks/data/repositories/looks_repository_impl.dart';
import 'package:looks_loop/features/looks/domain/usecases/get_look_detail_usecase.dart';
import 'package:looks_loop/features/looks/domain/usecases/get_looks_usecase.dart';

class FakeLooksRemoteDataSource implements LooksRemoteDataSource {
  List<LookSummaryModel> Function()? getLooksHandler;
  FeaturedLookModel Function(String slug)? getLookDetailHandler;

  @override
  Future<List<LookSummaryModel>> getLooks() async {
    return getLooksHandler!();
  }

  @override
  Future<FeaturedLookModel> getLookDetail(String slug) async {
    return getLookDetailHandler!(slug);
  }
}

void main() {
  const dummyLookModel = LookSummaryModel(
    id: 1,
    slug: 'soft-tailoring',
    title: 'Soft Tailoring',
    description: 'Description',
    image: 'https://example.com/look.jpg',
  );

  const dummyDetailModel = FeaturedLookModel(
    id: 1,
    slug: 'soft-tailoring',
    title: 'Soft Tailoring',
    description: 'Description',
    imageUrl: 'https://example.com/look.jpg',
    hotspots: [],
  );

  group('LooksRepositoryImpl', () {
    test('getLooks returns ApiSuccess when remote data source succeeds', () async {
      final fakeDataSource = FakeLooksRemoteDataSource()
        ..getLooksHandler = () => [dummyLookModel];
      final repository = LooksRepositoryImpl(fakeDataSource);

      final result = await repository.getLooks();

      expect(result, isA<ApiSuccess>());
      expect((result as ApiSuccess).data, equals([dummyLookModel]));
    });

    test('getLooks returns ApiFailure when remote data source throws', () async {
      final fakeDataSource = FakeLooksRemoteDataSource()
        ..getLooksHandler = () => throw Exception('Network error');
      final repository = LooksRepositoryImpl(fakeDataSource);

      final result = await repository.getLooks();

      expect(result, isA<ApiFailure>());
    });

    test('getLookDetail returns ApiSuccess when remote data source succeeds', () async {
      final fakeDataSource = FakeLooksRemoteDataSource()
        ..getLookDetailHandler = (_) => dummyDetailModel;
      final repository = LooksRepositoryImpl(fakeDataSource);

      final result = await repository.getLookDetail('soft-tailoring');

      expect(result, isA<ApiSuccess>());
      expect((result as ApiSuccess).data, equals(dummyDetailModel));
    });

    test('getLookDetail returns ApiFailure when remote data source throws', () async {
      final fakeDataSource = FakeLooksRemoteDataSource()
        ..getLookDetailHandler = (_) => throw Exception('Not found');
      final repository = LooksRepositoryImpl(fakeDataSource);

      final result = await repository.getLookDetail('soft-tailoring');

      expect(result, isA<ApiFailure>());
    });
  });

  group('Looks UseCases', () {
    test('GetLooksUseCase calls repository.getLooks', () async {
      final fakeDataSource = FakeLooksRemoteDataSource()
        ..getLooksHandler = () => [dummyLookModel];
      final repository = LooksRepositoryImpl(fakeDataSource);
      final useCase = GetLooksUseCase(repository);

      final result = await useCase();

      expect(result, isA<ApiSuccess>());
    });

    test('GetLookDetailUseCase calls repository.getLookDetail', () async {
      final fakeDataSource = FakeLooksRemoteDataSource()
        ..getLookDetailHandler = (_) => dummyDetailModel;
      final repository = LooksRepositoryImpl(fakeDataSource);
      final useCase = GetLookDetailUseCase(repository);

      final result = await useCase('soft-tailoring');

      expect(result, isA<ApiSuccess>());
    });
  });
}
