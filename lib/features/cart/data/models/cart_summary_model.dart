import 'package:looks_loop/features/cart/domain/entities/cart_summary_entity.dart';

class CartSummaryModel extends CartSummaryEntity {
  const CartSummaryModel({
    required super.subtotal,
    required super.discount,
    super.deliveryText = 'Calculated at checkout',
    required super.total,
    super.currency = 'EGP',
  });

  factory CartSummaryModel.fromJson(Map<String, dynamic> json) {
    return CartSummaryModel(
      subtotal: double.tryParse(json['subtotal']?.toString() ?? '') ?? 0.0,
      discount: double.tryParse(json['discount']?.toString() ?? '') ?? 0.0,
      deliveryText: json['delivery_text'] as String? ?? 'Calculated at checkout',
      total: double.tryParse(json['total']?.toString() ?? '') ?? 0.0,
      currency: json['currency'] as String? ?? 'EGP',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal,
      'discount': discount,
      'delivery_text': deliveryText,
      'total': total,
      'currency': currency,
    };
  }
}
