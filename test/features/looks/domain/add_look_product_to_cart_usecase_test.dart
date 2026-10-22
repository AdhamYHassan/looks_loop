import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/cart/domain/entities/add_to_cart_params.dart';
import 'package:looks_loop/features/cart/domain/repositories/cart_repository.dart';
import 'package:looks_loop/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/looks/domain/usecases/add_look_product_to_cart_usecase.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_size_entity.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_variant_entity.dart';
import 'package:looks_loop/features/product_detail/domain/repositories/product_detail_repository.dart';
import 'package:looks_loop/features/product_detail/domain/usecases/get_product_detail_usecase.dart';

class _FakeProductDetailRepo implements ProductDetailRepository {
  ApiResult<ProductDetailEntity>? result;

  @override
  Future<ApiResult<ProductDetailEntity>> getProductDetail(String slug) async =>
      result!;
}

class _FakeCartRepo implements CartRepository {
  AddToCartParams? capturedParams;
  ApiResult<void>? result;

  @override
  Future<ApiResult<void>> addToCart(AddToCartParams params) async {
    capturedParams = params;
    return result!;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _FakeProductDetailRepo fakeProductDetailRepo;
  late _FakeCartRepo fakeCartRepo;
  late AddLookProductToCartUseCase useCase;

  const dummyProductDetail = ProductDetailEntity(
    id: 42,
    slug: 'blazer',
    name: 'Tailored Blazer',
    brand: 'MANGO',
    price: 3500.0,
    description: 'A stylish blazer.',
    materialCare: 'Dry clean only',
    sizeFit: 'Regular fit',
    colors: [
      ProductColorEntity(id: 1, name: 'Black', hex: '#000000'),
    ],
    sizes: [
      ProductSizeEntity(id: 10, label: 'M'),
      ProductSizeEntity(id: 11, label: 'L'),
    ],
    variants: [
      ProductVariantEntity(
        id: 99,
        sku: 'BLZ-M',
        colorId: 1,
        sizeId: 10,
        stock: 5,
        isAvailable: true,
      ),
    ],
    images: [],
  );

  setUp(() {
    fakeProductDetailRepo = _FakeProductDetailRepo();
    fakeCartRepo = _FakeCartRepo();
    useCase = AddLookProductToCartUseCase(
      GetProductDetailUseCase(fakeProductDetailRepo),
      AddToCartUseCase(fakeCartRepo),
    );
  });

  test('resolves variant and successfully adds to cart', () async {
    fakeProductDetailRepo.result = const ApiSuccess(dummyProductDetail);
    fakeCartRepo.result = const ApiSuccess(null);

    final res = await useCase(
      productSlug: 'blazer',
      productId: '42',
      colorId: 1,
      sizeLabel: 'M',
    );

    expect(res, isA<ApiSuccess<void>>());
    expect(fakeCartRepo.capturedParams?.productId, equals(42));
    expect(fakeCartRepo.capturedParams?.variantId, equals(99));
    expect(fakeCartRepo.capturedParams?.sizeId, equals(10));
    expect(fakeCartRepo.capturedParams?.colorId, equals(1));
  });

  test('returns ApiFailure when product detail lookup fails', () async {
    fakeProductDetailRepo.result =
        const ApiFailure(ServerFailure('Product not found'));

    final res = await useCase(
      productSlug: 'unknown',
      productId: '0',
      colorId: 1,
      sizeLabel: 'M',
    );

    expect(res, isA<ApiFailure<void>>());
    expect(fakeCartRepo.capturedParams, isNull);
  });
}
