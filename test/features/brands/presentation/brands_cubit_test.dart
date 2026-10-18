import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/brands/domain/entities/brand_entity.dart';
import 'package:looks_loop/features/brands/domain/entities/get_brands_params.dart';
import 'package:looks_loop/features/brands/domain/repositories/brands_repository.dart';
import 'package:looks_loop/features/brands/domain/usecases/get_brands_usecase.dart';
import 'package:looks_loop/features/brands/presentation/bloc/brands_cubit.dart';
import 'package:looks_loop/features/brands/presentation/bloc/brands_state.dart';

class MockBrandsRepository implements BrandsRepository {
  final Future<ApiResult<List<BrandEntity>>> Function(GetBrandsParams params) handler;

  MockBrandsRepository(this.handler);

  @override
  Future<ApiResult<List<BrandEntity>>> getBrands(GetBrandsParams params) {
    return handler(params);
  }
}

void main() {
  const brandA = BrandEntity(
    id: 1,
    name: 'Apple Store',
    slug: 'apple',
    logo: '',
    isFeatured: true,
    productCount: 10,
  );
  const brandZ = BrandEntity(
    id: 2,
    name: 'ZARA',
    slug: 'zara',
    logo: '',
    isFeatured: false,
    productCount: 5,
  );

  test('loadBrands emits [BrandsLoading, BrandsLoaded] with sorted az & featured brands',
      () async {
    final repo = MockBrandsRepository((params) async {
      return const ApiSuccess([brandZ, brandA]);
    });
    final cubit = BrandsCubit(GetBrandsUseCase(repo));

    expectLater(
      cubit.stream,
      emitsInOrder([
        const BrandsLoading(),
        predicate<BrandsLoaded>((state) {
          return state.allBrands.first.name == 'Apple Store' &&
              state.featuredBrands.length == 1 &&
              state.featuredBrands.first.name == 'Apple Store' &&
              state.azBrands.containsKey('A') &&
              state.azBrands.containsKey('Z');
        }),
      ]),
    );

    await cubit.loadBrands();
    await cubit.close();
  });

  test('loadBrands emits [BrandsLoading, BrandsError] on failure', () async {
    final repo = MockBrandsRepository((params) async {
      return const ApiFailure<List<BrandEntity>>(ServerFailure('Fetch Failed'));
    });
    final cubit = BrandsCubit(GetBrandsUseCase(repo));

    expectLater(
      cubit.stream,
      emitsInOrder([
        const BrandsLoading(),
        const BrandsError('Fetch Failed'),
      ]),
    );

    await cubit.loadBrands();
    await cubit.close();
  });
}
