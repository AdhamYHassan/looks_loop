import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/checkout/domain/entities/placed_order_entity.dart';

class PlaceOrderResponseModel extends Equatable {
  final String orderNumber;
  final String message;
  final double? total;

  const PlaceOrderResponseModel({
    required this.orderNumber,
    this.message = '',
    this.total,
  });

  factory PlaceOrderResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final numStr = data['order_number']?.toString() ??
        data['orderNumber']?.toString() ??
        data['id']?.toString() ??
        '';

    final totalVal = data['total'] != null
        ? double.tryParse(data['total'].toString())
        : null;

    final msg =
        json['message']?.toString() ?? data['message']?.toString() ?? '';

    return PlaceOrderResponseModel(
      orderNumber: numStr,
      message: msg,
      total: totalVal,
    );
  }

  PlacedOrderEntity toEntity() => PlacedOrderEntity(
        orderNumber: orderNumber,
        message: message,
        total: total,
      );

  @override
  List<Object?> get props => [orderNumber, message, total];
}
