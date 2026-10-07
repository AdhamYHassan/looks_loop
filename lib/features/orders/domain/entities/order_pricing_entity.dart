import 'package:equatable/equatable.dart';

class OrderPricingEntity extends Equatable {
  final double subtotal;
  final double productSavings;
  final double voucherDiscount;
  final double deliveryFee;
  final double total;

  const OrderPricingEntity({
    required this.subtotal,
    required this.productSavings,
    required this.voucherDiscount,
    required this.deliveryFee,
    required this.total,
  });

  double get totalDiscount => productSavings + voucherDiscount;

  @override
  List<Object?> get props => [
        subtotal,
        productSavings,
        voucherDiscount,
        deliveryFee,
        total,
      ];
}
