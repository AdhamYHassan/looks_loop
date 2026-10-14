import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/cart/domain/entities/add_to_cart_params.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_summary_entity.dart';
import 'package:looks_loop/features/cart/domain/repositories/cart_repository.dart';
import 'package:looks_loop/features/cart/domain/usecases/add_to_cart_usecase.dart';
import '../data/product_detail_mock_data.dart';
import 'package:looks_loop/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:looks_loop/features/product_detail/domain/repositories/product_detail_repository.dart';
import 'package:looks_loop/features/product_detail/domain/usecases/get_product_detail_usecase.dart';
import 'package:looks_loop/features/product_detail/presentation/bloc/product_detail_cubit.dart';
import 'package:looks_loop/features/product_detail/presentation/bloc/product_detail_state.dart';

class FakeProductDetailRepository implements ProductDetailRepository {
  final ApiResult<ProductDetailEntity> result;

  const FakeProductDetailRepository(this.result);

  @override
  Future<ApiResult<ProductDetailEntity>> getProductDetail(String slug) async {
    return result;
  }
}

class FakeCartRepository implements CartRepository {
  AddToCartParams? lastAddedParams;
  ApiResult<void> addResult;

  FakeCartRepository({this.addResult = const ApiSuccess(null)});

  @override
  Future<ApiResult<void>> addToCart(AddToCartParams params) async {
    lastAddedParams = params;
    return addResult;
  }

  @override
  Future<ApiResult<CartEntity>> getCart() async => const ApiSuccess(
        CartEntity(items: [], summary: CartSummaryEntity(subtotal: 0, discount: 0, total: 0)),
      );

  @override
  Future<ApiResult<CartEntity>> updateQuantity({required String itemId, required int quantity}) async =>
      const ApiSuccess(
        CartEntity(items: [], summary: CartSummaryEntity(subtotal: 0, discount: 0, total: 0)),
      );

  @override
  Future<ApiResult<CartEntity>> removeItem(String itemId) async => const ApiSuccess(
        CartEntity(items: [], summary: CartSummaryEntity(subtotal: 0, discount: 0, total: 0)),
      );

  @override
  Future<ApiResult<CartEntity>> applyPromoCode(String promoCode) async => const ApiSuccess(
        CartEntity(items: [], summary: CartSummaryEntity(subtotal: 0, discount: 0, total: 0)),
      );

  @override
  Future<ApiResult<CartEntity>> removePromoCode() async => const ApiSuccess(
        CartEntity(items: [], summary: CartSummaryEntity(subtotal: 0, discount: 0, total: 0)),
      );
}

void main() {
  test('emits [Loading, Loaded] when loading product succeeds', () async {
    final cubit = ProductDetailCubit(
      GetProductDetailUseCase(
        const FakeProductDetailRepository(
          ApiSuccess(ProductDetailMockData.sampleProductDetail),
        ),
      ),
      AddToCartUseCase(FakeCartRepository()),
    );

    expect(
      cubit.stream,
      emitsInOrder([
        const ProductDetailLoading(),
        isA<ProductDetailLoaded>()
            .having((s) => s.product.name, 'name', 'White Cotton Shirt')
            .having((s) => s.selectedColorId, 'colorId', 16)
            .having((s) => s.selectedSizeId, 'sizeId', 36)
            .having((s) => s.selectedVariant?.sku, 'sku', 'LL-W011-BLA-XS'),
      ]),
    );

    await cubit.loadProductDetail('mango-white-cotton-shirt');
  });

  test('emits [Loading, Error] when loading product fails', () async {
    final cubit = ProductDetailCubit(
      GetProductDetailUseCase(
        const FakeProductDetailRepository(
          ApiFailure(UnknownFailure('Error loading product')),
        ),
      ),
      AddToCartUseCase(FakeCartRepository()),
    );

    expect(
      cubit.stream,
      emitsInOrder([
        const ProductDetailLoading(),
        const ProductDetailError('Error loading product'),
      ]),
    );

    await cubit.loadProductDetail('mango-white-cotton-shirt');
  });

  test('handles variant availability and addToBag with AddToCartUseCase', () async {
    final fakeCartRepo = FakeCartRepository();
    final cubit = ProductDetailCubit(
      GetProductDetailUseCase(
        const FakeProductDetailRepository(
          ApiSuccess(ProductDetailMockData.sampleProductDetail),
        ),
      ),
      AddToCartUseCase(fakeCartRepo),
    );

    await cubit.loadProductDetail('mango-white-cotton-shirt');
    final loaded = cubit.state as ProductDetailLoaded;

    expect(loaded.selectedColorId, 16);
    expect(loaded.selectedSizeId, 36);
    expect(loaded.isSelectedVariantAvailable, isTrue);

    // Select available size 37 (S)
    cubit.selectSize(37);
    final updated = cubit.state as ProductDetailLoaded;
    expect(updated.selectedSizeId, 37);

    // Call addToBag
    await cubit.addToBag(quantity: 1);
    expect(fakeCartRepo.lastAddedParams?.productId, 8);
    expect(fakeCartRepo.lastAddedParams?.colorId, 16);
    expect(fakeCartRepo.lastAddedParams?.sizeId, 37);
    expect(fakeCartRepo.lastAddedParams?.quantity, 1);
    expect((cubit.state as ProductDetailLoaded).bagCount, 4);
    expect((cubit.state as ProductDetailLoaded).bagActionMessage, 'Added to bag');
  });
}
