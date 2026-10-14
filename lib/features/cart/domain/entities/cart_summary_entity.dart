import 'package:equatable/equatable.dart';

class CartSummaryEntity extends Equatable {
  final double subtotal;
  final double discount;
  final String deliveryText;
  final double total;
  final String currency;

  const CartSummaryEntity({
    required this.subtotal,
    required this.discount,
    this.deliveryText = 'Calculated at checkout',
    required this.total,
    this.currency = 'EGP',
  });

  CartSummaryEntity copyWith({
    double? subtotal,
    double? discount,
    String? deliveryText,
    double? total,
    String? currency,
  }) {
    return CartSummaryEntity(
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      deliveryText: deliveryText ?? this.deliveryText,
      total: total ?? this.total,
      currency: currency ?? this.currency,
    );
  }

  @override
  List<Object?> get props => [
        subtotal,
        discount,
        deliveryText,
        total,
        currency,
      ];
}
