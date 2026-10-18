import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/brands/domain/entities/brand_entity.dart';
import 'package:looks_loop/features/brands/domain/entities/get_brands_params.dart';
import 'package:looks_loop/features/brands/domain/repositories/brands_repository.dart';
import 'package:looks_loop/features/brands/domain/usecases/get_brands_usecase.dart';

class MockBrandsRepository implements BrandsRepository {
  final Future<ApiResult<List<BrandEntity>>> Function(GetBrandsParams params) handler;

  MockBrandsRepository(this.handler);

  @override
  Future<ApiResult<List<BrandEntity>>> getBrands(GetBrandsParams params) {
    return handler(params);
  }
}

void main() {
  const dummyBrands = [
    BrandEntity(
      id: 1,
      name: 'MANGO',
      slug: 'mango',
      description: 'Contemporary fashion',
      logo: 'https://example.com/mango.png',
      isFeatured: true,
      productCount: 15,
    ),
  ];

  test('GetBrandsUseCase returns ApiSuccess with brands list', () async {
    final repo = MockBrandsRepository((params) async {
      return const ApiSuccess(dummyBrands);
    });
    final useCase = GetBrandsUseCase(repo);

    final result = await useCase(const GetBrandsParams(q: 'mango'));

    expect(result, isA<ApiSuccess<List<BrandEntity>>>());
    final success = result as ApiSuccess<List<BrandEntity>>;
    expect(success.data.length, 1);
    expect(success.data.first.name, 'MANGO');
  });

  test('GetBrandsUseCase returns ApiFailure when repository fails', () async {
    final repo = MockBrandsRepository((params) async {
      return const ApiFailure<List<BrandEntity>>(ServerFailure('Server Error'));
    });
    final useCase = GetBrandsUseCase(repo);

    final result = await useCase();

    expect(result, isA<ApiFailure<List<BrandEntity>>>());
    final failure = result as ApiFailure<List<BrandEntity>>;
    expect(failure.failure.message, 'Server Error');
  });
}
