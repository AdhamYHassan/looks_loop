import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/shop/domain/entities/category_detail_entity.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';
import 'package:looks_loop/features/shop/domain/repositories/category_detail_repository.dart';
import 'package:looks_loop/features/shop/domain/usecases/get_category_detail_usecase.dart';

class MockCategoryDetailRepository implements CategoryDetailRepository {
  final ApiResult<CategoryDetailEntity> result;

  const MockCategoryDetailRepository(this.result);

  @override
  Future<ApiResult<CategoryDetailEntity>> getCategoryDetail(
    String audienceId,
  ) async =>
      result;
}

void main() {
  const dummyDetail = CategoryDetailEntity(
    audienceId: 'aud_women',
    audienceTitle: 'WOMEN',
    totalProductCount: 42,
    subcategories: [
      SubCategoryEntity(
        id: 'sub_1',
        name: 'CLOTHING',
        productCount: 18,
        imageUrl: '',
      ),
    ],
    editorial: ShopEditorialEntity(
      eyebrow: 'SUMMER',
      titleLine1: 'LINE 1',
      titleLine2: 'LINE 2',
      ctaText: 'DISCOVER',
      imageUrl: '',
    ),
    railProducts: [],
  );

  test('GetCategoryDetailUseCase returns ApiSuccess with CategoryDetailEntity',
      () async {
    const repository = MockCategoryDetailRepository(ApiSuccess(dummyDetail));
    final useCase = GetCategoryDetailUseCase(repository);

    final result = await useCase('aud_women');

    expect(result, isA<ApiSuccess<CategoryDetailEntity>>());
    expect((result as ApiSuccess<CategoryDetailEntity>).data, equals(dummyDetail));
  });

  test('GetCategoryDetailUseCase returns ApiFailure when repository fails',
      () async {
    const repository = MockCategoryDetailRepository(
      ApiFailure(ServerFailure('Failed to load')),
    );
    final useCase = GetCategoryDetailUseCase(repository);

    final result = await useCase('aud_women');

    expect(result, isA<ApiFailure<CategoryDetailEntity>>());
    expect(
      (result as ApiFailure<CategoryDetailEntity>).failure.message,
      equals('Failed to load'),
    );
  });
}
