import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_item_entity.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_summary_entity.dart';

class CartEntity extends Equatable {
  final List<CartItemEntity> items;
  final String? appliedPromoCode;
  final double discountAmount;
  final CartSummaryEntity summary;

  const CartEntity({
    required this.items,
    this.appliedPromoCode,
    this.discountAmount = 0.0,
    required this.summary,
  });

  int get totalItemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  bool get isEmpty => items.isEmpty;

  CartEntity copyWith({
    List<CartItemEntity>? items,
    String? appliedPromoCode,
    double? discountAmount,
    CartSummaryEntity? summary,
  }) {
    return CartEntity(
      items: items ?? this.items,
      appliedPromoCode: appliedPromoCode ?? this.appliedPromoCode,
      discountAmount: discountAmount ?? this.discountAmount,
      summary: summary ?? this.summary,
    );
  }

  @override
  List<Object?> get props => [
        items,
        appliedPromoCode,
        discountAmount,
        summary,
      ];
}
