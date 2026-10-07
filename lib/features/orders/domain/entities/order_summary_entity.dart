import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/orders/domain/entities/order_status.dart';

/// Lightweight order representation shown in the orders list.
class OrderSummaryEntity extends Equatable {
  final String orderNumber;
  final DateTime? createdAt;
  final OrderStatus status;
  final String statusDisplay;
  final double total;
  final int itemCount;
  final List<String> images;

  const OrderSummaryEntity({
    required this.orderNumber,
    required this.createdAt,
    required this.status,
    required this.statusDisplay,
    required this.total,
    required this.itemCount,
    required this.images,
  });

  @override
  List<Object?> get props => [
        orderNumber,
        createdAt,
        status,
        statusDisplay,
        total,
        itemCount,
        images,
      ];
}
