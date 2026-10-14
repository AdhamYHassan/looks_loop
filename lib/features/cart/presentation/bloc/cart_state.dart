import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final CartEntity cart;
  final String? promoError;
  final bool isApplyingPromo;

  const CartLoaded(
    this.cart, {
    this.promoError,
    this.isApplyingPromo = false,
  });

  CartLoaded copyWith({
    CartEntity? cart,
    String? promoError,
    bool clearPromoError = false,
    bool? isApplyingPromo,
  }) {
    return CartLoaded(
      cart ?? this.cart,
      promoError: clearPromoError ? null : (promoError ?? this.promoError),
      isApplyingPromo: isApplyingPromo ?? this.isApplyingPromo,
    );
  }

  @override
  List<Object?> get props => [cart, promoError, isApplyingPromo];
}

class CartEmpty extends CartState {
  const CartEmpty();
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
