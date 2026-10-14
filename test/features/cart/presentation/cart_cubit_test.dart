import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/cart/domain/entities/add_to_cart_params.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_summary_entity.dart';
import 'package:looks_loop/features/cart/domain/repositories/cart_repository.dart';
import 'package:looks_loop/features/cart/domain/usecases/apply_promo_code_usecase.dart';
import 'package:looks_loop/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:looks_loop/features/cart/domain/usecases/remove_cart_item_usecase.dart';
import 'package:looks_loop/features/cart/domain/usecases/remove_promo_code_usecase.dart';
import 'package:looks_loop/features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:looks_loop/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:looks_loop/features/cart/presentation/bloc/cart_state.dart';

class MockCartRepository implements CartRepository {
  ApiResult<CartEntity> cartResult;

  MockCartRepository(this.cartResult);

  @override
  Future<ApiResult<CartEntity>> getCart() async => cartResult;

  @override
  Future<ApiResult<void>> addToCart(AddToCartParams params) async =>
      const ApiSuccess(null);

  @override
  Future<ApiResult<CartEntity>> updateQuantity({
    required String itemId,
    required int quantity,
  }) async =>
      cartResult;

  @override
  Future<ApiResult<CartEntity>> removeItem(String itemId) async => cartResult;

  @override
  Future<ApiResult<CartEntity>> applyPromoCode(String promoCode) async =>
      cartResult;

  @override
  Future<ApiResult<CartEntity>> removePromoCode() async => cartResult;
}

void main() {
  const dummyItem = CartItemEntity(
    id: '1',
    productId: '8',
    slug: 'mango-relaxed-linen-shirt',
    brand: 'MANGO',
    name: 'Relaxed Linen Shirt',
    variantDescription: 'White / M',
    imageUrl: 'https://example.com/shirt.jpg',
    price: 1450.0,
    quantity: 1,
  );

  const dummyCart = CartEntity(
    items: [dummyItem],
    appliedPromoCode: null,
    discountAmount: 0.0,
    summary: CartSummaryEntity(
      subtotal: 1450.0,
      discount: 0.0,
      total: 1450.0,
    ),
  );

  CartCubit createCubit(MockCartRepository repo) {
    return CartCubit(
      GetCartUseCase(repo),
      UpdateCartQuantityUseCase(repo),
      RemoveCartItemUseCase(repo),
      ApplyPromoCodeUseCase(repo),
      RemovePromoCodeUseCase(repo),
    );
  }

  test('CartCubit emits [CartLoading, CartLoaded] on successful fetch with items',
      () async {
    final repo = MockCartRepository(const ApiSuccess(dummyCart));
    final cubit = createCubit(repo);

    expectLater(
      cubit.stream,
      emitsInOrder([
        const CartLoading(),
        const CartLoaded(dummyCart),
      ]),
    );

    await cubit.getCart();
  });

  test('CartCubit emits [CartLoading, CartEmpty] when cart is empty', () async {
    const emptyCart = CartEntity(
      items: [],
      summary: CartSummaryEntity(subtotal: 0.0, discount: 0.0, total: 0.0),
    );
    final repo = MockCartRepository(const ApiSuccess(emptyCart));
    final cubit = createCubit(repo);

    expectLater(
      cubit.stream,
      emitsInOrder([
        const CartLoading(),
        const CartEmpty(),
      ]),
    );

    await cubit.getCart();
  });

  test('CartCubit emits [CartLoading, CartError] on repository failure',
      () async {
    final repo = MockCartRepository(
      const ApiFailure(ServerFailure('Failed to load cart')),
    );
    final cubit = createCubit(repo);

    expectLater(
      cubit.stream,
      emitsInOrder([
        const CartLoading(),
        const CartError('Failed to load cart'),
      ]),
    );

    await cubit.getCart();
  });

  test('CartCubit applies voucher and updates state', () async {
    const withVoucher = CartEntity(
      items: [dummyItem],
      appliedPromoCode: 'WELCOME200',
      discountAmount: 200.0,
      summary: CartSummaryEntity(subtotal: 1450.0, discount: 200.0, total: 1250.0),
    );
    final repo = MockCartRepository(const ApiSuccess(dummyCart));
    final cubit = createCubit(repo);

    await cubit.getCart();
    repo.cartResult = const ApiSuccess(withVoucher);
    await cubit.applyPromoCode('WELCOME200');

    expect(cubit.state, isA<CartLoaded>());
    expect((cubit.state as CartLoaded).cart.appliedPromoCode, 'WELCOME200');
  });

  test('CartCubit removes voucher and updates state', () async {
    const withVoucher = CartEntity(
      items: [dummyItem],
      appliedPromoCode: 'WELCOME200',
      discountAmount: 200.0,
      summary: CartSummaryEntity(subtotal: 1450.0, discount: 200.0, total: 1250.0),
    );
    final repo = MockCartRepository(const ApiSuccess(withVoucher));
    final cubit = createCubit(repo);

    await cubit.getCart();
    repo.cartResult = const ApiSuccess(dummyCart);
    await cubit.removePromoCode();

    expect(cubit.state, isA<CartLoaded>());
    expect((cubit.state as CartLoaded).cart.appliedPromoCode, isNull);
  });
}
