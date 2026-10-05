import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/shop/data/datasources/category_detail_remote_data_source.dart';
import 'package:looks_loop/features/shop/data/models/category_detail_models.dart';
import 'package:looks_loop/features/shop/data/models/shop_feed_models.dart';
import 'package:looks_loop/features/shop/data/repositories/category_detail_repository_impl.dart';

class MockRemoteDataSource implements CategoryDetailRemoteDataSource {
  final CategoryDetailModel? model;
  final Exception? exception;

  const MockRemoteDataSource({this.model, this.exception});

  @override
  Future<CategoryDetailModel> getCategoryDetail(String audienceId) async {
    if (exception != null) {
      throw exception!;
    }
    return model!;
  }
}

void main() {
  const dummyModel = CategoryDetailModel(
    audienceId: 'aud_women',
    audienceTitle: 'WOMEN',
    totalProductCount: 42,
    subcategories: [],
    editorial: ShopEditorialModel(
      eyebrow: 'TEST',
      titleLine1: 'LINE 1',
      titleLine2: 'LINE 2',
      ctaText: 'CTA',
      imageUrl: '',
    ),
    railProducts: [],
  );

  test('CategoryDetailRepositoryImpl returns ApiSuccess on valid response',
      () async {
    const dataSource = MockRemoteDataSource(model: dummyModel);
    final repo = CategoryDetailRepositoryImpl(dataSource);

    final result = await repo.getCategoryDetail('aud_women');

    expect(result, isA<ApiSuccess>());
    expect((result as ApiSuccess).data, equals(dummyModel));
  });

  test('CategoryDetailRepositoryImpl catches FormatException and maps to ServerFailure',
      () async {
    final dataSource = MockRemoteDataSource(
      exception: const FormatException('Invalid JSON'),
    );
    final repo = CategoryDetailRepositoryImpl(dataSource);

    final result = await repo.getCategoryDetail('aud_women');

    expect(result, isA<ApiFailure>());
    expect((result as ApiFailure).failure, isA<ServerFailure>());
  });

  test('CategoryDetailRepositoryImpl catches generic Exception and maps to UnknownFailure',
      () async {
    final dataSource = MockRemoteDataSource(
      exception: Exception('Network timeout'),
    );
    final repo = CategoryDetailRepositoryImpl(dataSource);

    final result = await repo.getCategoryDetail('aud_women');

    expect(result, isA<ApiFailure>());
    expect((result as ApiFailure).failure, isA<UnknownFailure>());
  });
}
