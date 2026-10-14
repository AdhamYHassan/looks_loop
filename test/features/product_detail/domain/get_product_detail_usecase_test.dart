import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import '../data/product_detail_mock_data.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:looks_loop/features/product_detail/domain/repositories/product_detail_repository.dart';
import 'package:looks_loop/features/product_detail/domain/usecases/get_product_detail_usecase.dart';

class FakeProductDetailRepository implements ProductDetailRepository {
  final ApiResult<ProductDetailEntity> result;

  const FakeProductDetailRepository(this.result);

  @override
  Future<ApiResult<ProductDetailEntity>> getProductDetail(String productId) async {
    return result;
  }
}

void main() {
  test('returns ApiSuccess when repository succeeds', () async {
    final repository = FakeProductDetailRepository(
      const ApiSuccess(ProductDetailMockData.sampleProductDetail),
    );
    final useCase = GetProductDetailUseCase(repository);

    final result = await useCase('prod_linen_shirt');

    expect(result, isA<ApiSuccess<ProductDetailEntity>>());
    final data = (result as ApiSuccess<ProductDetailEntity>).data;
    expect(data.brand, 'MANGO');
    expect(data.name, 'White Cotton Shirt');
  });

  test('returns ApiFailure when repository fails', () async {
    const repository = FakeProductDetailRepository(
      ApiFailure(UnknownFailure('Network error')),
    );
    final useCase = GetProductDetailUseCase(repository);

    final result = await useCase('prod_linen_shirt');

    expect(result, isA<ApiFailure<ProductDetailEntity>>());
    final failure = (result as ApiFailure<ProductDetailEntity>).failure;
    expect(failure.message, 'Network error');
  });
}
