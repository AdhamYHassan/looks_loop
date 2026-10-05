import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/shop/domain/entities/category_detail_entity.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';
import 'package:looks_loop/features/shop/domain/repositories/category_detail_repository.dart';
import 'package:looks_loop/features/shop/domain/usecases/get_category_detail_usecase.dart';
import 'package:looks_loop/features/shop/presentation/bloc/category_detail_cubit.dart';
import 'package:looks_loop/features/shop/presentation/bloc/category_detail_state.dart';

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
    subcategories: [],
    editorial: ShopEditorialEntity(
      eyebrow: 'SUMMER',
      titleLine1: 'LINE 1',
      titleLine2: 'LINE 2',
      ctaText: 'DISCOVER',
      imageUrl: '',
    ),
    railProducts: [],
  );

  test('CategoryDetailCubit emits [Loading, Loaded] upon successful fetch',
      () async {
    const repository = MockCategoryDetailRepository(ApiSuccess(dummyDetail));
    final cubit = CategoryDetailCubit(GetCategoryDetailUseCase(repository));

    expectLater(
      cubit.stream,
      emitsInOrder([
        const CategoryDetailLoading(),
        const CategoryDetailLoaded(data: dummyDetail),
      ]),
    );

    await cubit.loadCategoryDetail('aud_women');
  });

  test('CategoryDetailCubit emits [Loading, Error] upon fetch failure',
      () async {
    const repository = MockCategoryDetailRepository(
      ApiFailure(ServerFailure('Connection failed')),
    );
    final cubit = CategoryDetailCubit(GetCategoryDetailUseCase(repository));

    expectLater(
      cubit.stream,
      emitsInOrder([
        const CategoryDetailLoading(),
        const CategoryDetailError('Connection failed'),
      ]),
    );

    await cubit.loadCategoryDetail('aud_women');
  });

  test('toggleWishlist adds and removes product id in CategoryDetailLoaded state',
      () async {
    const repository = MockCategoryDetailRepository(ApiSuccess(dummyDetail));
    final cubit = CategoryDetailCubit(GetCategoryDetailUseCase(repository));

    await cubit.loadCategoryDetail('aud_women');

    cubit.toggleWishlist('p1');
    expect(
      (cubit.state as CategoryDetailLoaded).wishlistedProductIds,
      contains('p1'),
    );

    cubit.toggleWishlist('p1');
    expect(
      (cubit.state as CategoryDetailLoaded).wishlistedProductIds,
      isNot(contains('p1')),
    );
  });
}
