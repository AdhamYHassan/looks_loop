import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/brands/data/datasources/brands_remote_data_source.dart';
import 'package:looks_loop/features/brands/data/models/brand_model.dart';
import 'package:looks_loop/features/brands/data/repositories/brands_repository_impl.dart';
import 'package:looks_loop/features/brands/domain/entities/get_brands_params.dart';

class MockBrandsRemoteDataSource implements BrandsRemoteDataSource {
  final Future<List<BrandModel>> Function(GetBrandsParams params) handler;

  MockBrandsRemoteDataSource(this.handler);

  @override
  Future<List<BrandModel>> getBrands(GetBrandsParams params) async {
    return handler(params);
  }
}

void main() {
  const dummyModel = BrandModel(
    id: 1,
    name: 'ZARA',
    slug: 'zara',
    description: 'Fast fashion',
    logo: 'https://example.com/zara.png',
    isFeatured: true,
    productCount: 13,
  );

  test('BrandsRepositoryImpl returns ApiSuccess when remote data source succeeds',
      () async {
    final dataSource = MockBrandsRemoteDataSource((params) async {
      return [dummyModel];
    });
    final repository = BrandsRepositoryImpl(dataSource);

    final result = await repository.getBrands(const GetBrandsParams());

    expect(result, isA<ApiSuccess>());
    final success = result as ApiSuccess;
    expect(success.data.first.name, 'ZARA');
  });

  test('BrandsRepositoryImpl returns ApiFailure when remote data source throws',
      () async {
    final dataSource = MockBrandsRemoteDataSource((params) async {
      throw Exception('Network crash');
    });
    final repository = BrandsRepositoryImpl(dataSource);

    final result = await repository.getBrands(const GetBrandsParams());

    expect(result, isA<ApiFailure>());
  });
}
