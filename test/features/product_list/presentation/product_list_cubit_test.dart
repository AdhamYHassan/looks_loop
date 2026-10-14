import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_entities.dart';
import 'package:looks_loop/features/product_list/domain/repositories/product_list_repository.dart';
import 'package:looks_loop/features/product_list/domain/usecases/get_products_usecase.dart';
import 'package:looks_loop/features/product_list/presentation/bloc/product_list_cubit.dart';
import 'package:looks_loop/features/product_list/presentation/bloc/product_list_state.dart';

class MockProductListRepository implements ProductListRepository {
  final ApiResult<ProductListEntity> Function(GetProductsParams params) handler;

  MockProductListRepository(this.handler);

  @override
  Future<ApiResult<ProductListEntity>> getProducts(
    GetProductsParams params,
  ) async {
    return handler(params);
  }
}

void main() {
  const dummyProduct = ProductEntity(
    id: '49',
    slug: 'zara-layered-casual-set',
    name: 'Layered Casual Set',
    brand: 'ZARA',
    price: 2200.0,
    imageUrl: 'https://example.com/img.jpg',
  );

  const dummyData = ProductListEntity(
    count: 1,
    page: 1,
    numPages: 2,
    nextPage: 2,
    sort: 'recommended',
    sortOptions: [
      SortOptionEntity(value: 'recommended', label: 'RECOMMENDED'),
      SortOptionEntity(value: 'newest', label: 'NEWEST'),
    ],
    selected: SelectedFiltersEntity(),
    facets: ProductListFacetsEntity(
      brands: [BrandFacetEntity(slug: 'zara', name: 'ZARA', count: 1)],
      sizes: ['M'],
      colors: ['#000000'],
    ),
    results: [dummyProduct],
  );

  test('loadProducts emits [ProductListLoading, ProductListLoaded] on success',
      () async {
    final repo = MockProductListRepository((params) {
      return const ApiSuccess(dummyData);
    });

    final cubit = ProductListCubit(GetProductsUseCase(repo));

    expectLater(
      cubit.stream,
      emitsInOrder([
        const ProductListLoading(),
        isA<ProductListLoaded>()
            .having((s) => s.data.results.length, 'results length', 1)
            .having((s) => s.currentSort, 'sort', 'recommended'),
      ]),
    );

    await cubit.loadProducts(category: 'men', subcategory: 'clothing');
  });

  test('loadProducts emits [ProductListLoading, ProductListError] on failure',
      () async {
    final repo = MockProductListRepository((params) {
      return const ApiFailure(ServerFailure('Network error'));
    });

    final cubit = ProductListCubit(GetProductsUseCase(repo));

    expectLater(
      cubit.stream,
      emitsInOrder([
        const ProductListLoading(),
        const ProductListError('Network error'),
      ]),
    );

    await cubit.loadProducts(category: 'men', subcategory: 'clothing');
  });

  test('applyFilters reloads products with updated filters', () async {
    GetProductsParams? capturedParams;
    final repo = MockProductListRepository((params) {
      capturedParams = params;
      return const ApiSuccess(dummyData);
    });

    final cubit = ProductListCubit(GetProductsUseCase(repo));
    await cubit.loadProducts(category: 'men', subcategory: 'clothing');

    const newFilters = SelectedFiltersEntity(brands: ['zara'], sale: true);
    cubit.applyFilters(newFilters);
    await pumpEventQueue();

    expect(capturedParams?.brands, contains('zara'));
    expect(capturedParams?.sale, isTrue);
  });
}
