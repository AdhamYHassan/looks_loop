import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/orders/domain/entities/order_status.dart';

class OrderStatusHistoryEntity extends Equatable {
  final OrderStatus status;
  final String statusDisplay;
  final DateTime? at;

  const OrderStatusHistoryEntity({
    required this.status,
    required this.statusDisplay,
    this.at,
  });

  @override
  List<Object?> get props => [status, statusDisplay, at];
}
