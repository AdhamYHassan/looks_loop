import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:looks_loop/features/cart/domain/usecases/apply_promo_code_usecase.dart';
import 'package:looks_loop/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:looks_loop/features/cart/domain/usecases/remove_cart_item_usecase.dart';
import 'package:looks_loop/features/cart/domain/usecases/remove_promo_code_usecase.dart';
import 'package:looks_loop/features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:looks_loop/features/cart/presentation/bloc/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartUseCase _getCartUseCase;
  final UpdateCartQuantityUseCase _updateQuantityUseCase;
  final RemoveCartItemUseCase _removeCartItemUseCase;
  final ApplyPromoCodeUseCase _applyPromoCodeUseCase;
  final RemovePromoCodeUseCase _removePromoCodeUseCase;

  CartCubit(
    this._getCartUseCase,
    this._updateQuantityUseCase,
    this._removeCartItemUseCase,
    this._applyPromoCodeUseCase,
    this._removePromoCodeUseCase,
  ) : super(const CartInitial());

  Future<void> getCart() async {
    emit(const CartLoading());
    final result = await _getCartUseCase();
    _handleResult(result);
  }

  Future<void> updateQuantity({
    required String itemId,
    required int quantity,
  }) async {
    if (quantity <= 0) {
      await removeItem(itemId);
      return;
    }

    final previousState = state;
    if (previousState is CartLoaded) {
      final updatedItems = previousState.cart.items.map((item) {
        return item.id == itemId ? item.copyWith(quantity: quantity) : item;
      }).toList();

      emit(CartLoaded(_recalculateCart(previousState.cart, updatedItems)));
    }

    final result = await _updateQuantityUseCase(
      itemId: itemId,
      quantity: quantity,
    );

    switch (result) {
      case ApiSuccess():
        _handleResult(result);
      case ApiFailure():
        emit(previousState);
    }
  }

  Future<void> removeItem(String itemId) async {
    final previousState = state;
    if (previousState is CartLoaded) {
      final updatedItems = previousState.cart.items
          .where((item) => item.id != itemId)
          .toList();

      if (updatedItems.isEmpty) {
        emit(const CartEmpty());
      } else {
        emit(CartLoaded(_recalculateCart(previousState.cart, updatedItems)));
      }
    }

    final result = await _removeCartItemUseCase(itemId);
    switch (result) {
      case ApiSuccess():
        _handleResult(result);
      case ApiFailure():
        emit(previousState);
    }
  }

  CartEntity _recalculateCart(CartEntity cart, List<CartItemEntity> items) {
    final subtotal = items.fold<double>(0.0, (s, i) => s + i.totalPrice);
    final total = (subtotal - cart.discountAmount).clamp(0.0, double.infinity);
    return cart.copyWith(
      items: items,
      summary: cart.summary.copyWith(subtotal: subtotal, total: total),
    );
  }

  Future<void> applyPromoCode(String promoCode) async {
    _setPromoLoading();
    final result = await _applyPromoCodeUseCase(promoCode);
    _handlePromoResult(result);
  }

  Future<void> removePromoCode() async {
    _setPromoLoading();
    final result = await _removePromoCodeUseCase();
    _handlePromoResult(result);
  }

  void _setPromoLoading() {
    final s = state;
    if (s is CartLoaded) emit(s.copyWith(isApplyingPromo: true, clearPromoError: true));
  }

  void _handlePromoResult(ApiResult<CartEntity> result) {
    switch (result) {
      case ApiSuccess(:final data):
        emit(CartLoaded(data));
      case ApiFailure(:final failure):
        final s = state;
        if (s is CartLoaded) {
          emit(s.copyWith(isApplyingPromo: false, promoError: failure.message));
        } else {
          emit(CartError(failure.message));
        }
    }
  }

  void _handleResult(ApiResult<CartEntity> result) {
    switch (result) {
      case ApiSuccess(:final data):
        emit(data.isEmpty ? const CartEmpty() : CartLoaded(data));
      case ApiFailure(:final failure):
        emit(CartError(failure.message));
    }
  }
}
