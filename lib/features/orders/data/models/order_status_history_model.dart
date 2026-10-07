import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/orders/domain/entities/order_status.dart';
import 'package:looks_loop/features/orders/domain/entities/order_status_history_entity.dart';

class OrderStatusHistoryModel extends Equatable {
  final String status;
  final String statusDisplay;
  final DateTime? at;

  const OrderStatusHistoryModel({
    required this.status,
    required this.statusDisplay,
    this.at,
  });

  factory OrderStatusHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusHistoryModel(
      status: json['status'] as String? ?? '',
      statusDisplay: json['status_display'] as String? ?? '',
      at: json['at'] != null ? DateTime.tryParse(json['at'] as String) : null,
    );
  }

  OrderStatusHistoryEntity toEntity() {
    return OrderStatusHistoryEntity(
      status: OrderStatus.fromApi(status),
      statusDisplay: statusDisplay,
      at: at,
    );
  }

  @override
  List<Object?> get props => [status, statusDisplay, at];
}
