import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/orders/domain/entities/order_status.dart';
import 'package:looks_loop/features/orders/domain/entities/order_summary_entity.dart';

/// DTO for a single item of `orders/` results.
class OrderSummaryModel extends Equatable {
  final String orderNumber;
  final String? created;
  final String status;
  final String statusDisplay;
  final String total;
  final int itemCount;
  final List<String> images;

  const OrderSummaryModel({
    required this.orderNumber,
    required this.created,
    required this.status,
    required this.statusDisplay,
    required this.total,
    required this.itemCount,
    required this.images,
  });

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) {
    final rawImages = json['images'];
    return OrderSummaryModel(
      orderNumber: json['order_number'] as String? ?? '',
      created: json['created'] as String?,
      status: json['status'] as String? ?? '',
      statusDisplay: json['status_display'] as String? ?? '',
      total: json['total']?.toString() ?? '0',
      itemCount: json['item_count'] as int? ?? 0,
      images: rawImages is List ? rawImages.whereType<String>().toList() : [],
    );
  }

  OrderSummaryEntity toEntity() => OrderSummaryEntity(
        orderNumber: orderNumber,
        createdAt: created == null ? null : DateTime.tryParse(created!),
        status: OrderStatus.fromApi(status),
        statusDisplay: statusDisplay,
        total: double.tryParse(total) ?? 0,
        itemCount: itemCount,
        images: images,
      );

  @override
  List<Object?> get props =>
      [orderNumber, created, status, statusDisplay, total, itemCount, images];
}
