import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/orders/domain/entities/order_address_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_item_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_pricing_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_status.dart';
import 'package:looks_loop/features/orders/domain/entities/order_status_history_entity.dart';

class OrderDetailEntity extends Equatable {
  final String orderNumber;
  final DateTime? created;
  final OrderStatus status;
  final String statusDisplay;
  final List<OrderStatusHistoryEntity> statusHistory;
  final bool canCancel;
  final OrderAddressEntity address;
  final String paymentMethodDisplay;
  final OrderPricingEntity pricing;
  final List<OrderItemEntity> items;
  final int itemCount;

  const OrderDetailEntity({
    required this.orderNumber,
    this.created,
    required this.status,
    required this.statusDisplay,
    required this.statusHistory,
    required this.canCancel,
    required this.address,
    required this.paymentMethodDisplay,
    required this.pricing,
    required this.items,
    required this.itemCount,
  });

  @override
  List<Object?> get props => [
        orderNumber,
        created,
        status,
        statusDisplay,
        statusHistory,
        canCancel,
        address,
        paymentMethodDisplay,
        pricing,
        items,
        itemCount,
      ];
}
