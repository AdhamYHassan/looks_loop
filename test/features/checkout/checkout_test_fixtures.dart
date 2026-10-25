import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/domain/entities/add_address_params.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';
import 'package:looks_loop/features/address/domain/repositories/address_repository.dart';
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

class FakeCheckoutAddressRepo implements AddressRepository {
  final List<AddressEntity> addresses;
  final List<ProvinceEntity> provinces;
  FakeCheckoutAddressRepo(this.addresses, {this.provinces = const []});

  @override
  Future<ApiResult<List<AddressEntity>>> getAddresses() async =>
      ApiSuccess(addresses);

  @override
  Future<ApiResult<AddressEntity>> addAddress(AddAddressParams params) async =>
      ApiSuccess(addresses.first);

  @override
  Future<ApiResult<List<ProvinceEntity>>> getProvinces(
          {bool forceRefresh = false}) async =>
      ApiSuccess(provinces);
}

class FakeCheckoutCartRepo implements CartRepository {
  final CartEntity cart;
  FakeCheckoutCartRepo(this.cart);

  @override
  Future<ApiResult<CartEntity>> getCart() async => ApiSuccess(cart);
  @override
  Future<ApiResult<void>> addToCart(AddToCartParams params) async =>
      const ApiSuccess(null);
  @override
  Future<ApiResult<CartEntity>> updateQuantity(
          {required String itemId, required int quantity}) async =>
      ApiSuccess(cart);
  @override
  Future<ApiResult<CartEntity>> removeItem(String itemId) async =>
      ApiSuccess(cart);
  @override
  Future<ApiResult<CartEntity>> applyPromoCode(String promoCode) async =>
      ApiSuccess(cart);
  @override
  Future<ApiResult<CartEntity>> removePromoCode() async => ApiSuccess(cart);
}

CartCubit createTestCartCubit(CartEntity cart) {
  final repo = FakeCheckoutCartRepo(cart);
  return CartCubit(
    GetCartUseCase(repo),
    UpdateCartQuantityUseCase(repo),
    RemoveCartItemUseCase(repo),
    ApplyPromoCodeUseCase(repo),
    RemovePromoCodeUseCase(repo),
  );
}

const dummyCheckoutAddress1 = AddressEntity(
  id: 1,
  label: 'home',
  title: 'Home',
  displayLabel: 'Home',
  firstName: 'Sarah',
  lastName: 'Ahmed',
  fullName: 'Sarah Ahmed',
  phone: '01012345678',
  cityId: 1,
  cityName: 'Cairo',
  area: 'Zamalek',
  street: '26th of July St',
  building: '14',
  floor: '3',
  apartment: '12',
  landmark: '',
  isDefault: true,
  location: '',
  singleLine: '26th of July St, Bldg 14, Zamalek, Cairo',
  canDeliver: true,
);

const dummyCheckoutAddress2 = AddressEntity(
  id: 2,
  label: 'work',
  title: 'Work',
  displayLabel: 'Work',
  firstName: 'Sarah',
  lastName: 'Ahmed',
  fullName: 'Sarah Ahmed',
  phone: '01012345678',
  cityId: 1,
  cityName: 'Giza',
  area: 'Mohandessin',
  street: 'Syria St',
  building: '8',
  floor: '1',
  apartment: '2',
  landmark: '',
  isDefault: false,
  location: '',
  singleLine: 'Syria St, Bldg 8, Mohandessin, Giza',
  canDeliver: true,
);

const dummyCheckoutCart = CartEntity(
  items: [
    CartItemEntity(
      id: '1',
      productId: '8',
      brand: 'MANGO',
      name: 'Relaxed Linen Shirt',
      variantDescription: 'White / M',
      imageUrl: '',
      price: 1450.0,
      quantity: 1,
    ),
  ],
  summary: CartSummaryEntity(
    subtotal: 1450.0,
    discount: 0.0,
    total: 1450.0,
  ),
);
