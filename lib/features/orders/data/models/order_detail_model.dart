import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/orders/data/models/order_item_model.dart';
import 'package:looks_loop/features/orders/data/models/order_status_history_model.dart';
import 'package:looks_loop/features/orders/domain/entities/order_address_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_detail_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_pricing_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_status.dart';

class OrderDetailModel extends Equatable {
  final String orderNumber;
  final DateTime? created;
  final String status;
  final String statusDisplay;
  final List<OrderStatusHistoryModel> statusHistory;
  final bool canCancel;
  final OrderAddressEntity address;
  final String paymentMethodDisplay;
  final OrderPricingEntity pricing;
  final List<OrderItemModel> items;
  final int itemCount;

  const OrderDetailModel({
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

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    final root = json.containsKey('data') && json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final historyList = (root['status_history'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(OrderStatusHistoryModel.fromJson)
        .toList();

    final allItems = <OrderItemModel>[];
    final vendorOrders = root['vendor_orders'] as List<dynamic>? ?? const [];
    for (final vo in vendorOrders) {
      if (vo is Map<String, dynamic>) {
        final brandMap = vo['brand'] as Map<String, dynamic>?;
        final brandName = brandMap?['name'] as String? ?? '';
        final rawItems = vo['items'] as List<dynamic>? ?? const [];
        for (final item in rawItems) {
          if (item is Map<String, dynamic>) {
            allItems.add(OrderItemModel.fromJson(item, fallbackBrand: brandName));
          }
        }
      }
    }

    final subtotal = _parseDouble(root['subtotal']);
    final savings = _parseDouble(root['product_savings']);
    final discount = _parseDouble(root['voucher_discount']);
    final delivery = _parseDouble(root['delivery_fee']);
    final total = _parseDouble(root['total']);

    final address = OrderAddressEntity(
      fullName: root['full_name'] as String? ?? '',
      phone: root['phone'] as String? ?? '',
      street: root['street'] as String? ?? '',
      building: root['building'] as String? ?? '',
      floor: root['floor'] as String? ?? '',
      apartment: root['apartment'] as String? ?? '',
      area: root['area'] as String? ?? '',
      city: root['city'] as String? ?? '',
      fullAddress: root['address'] as String? ?? '',
    );

    return OrderDetailModel(
      orderNumber: root['order_number'] as String? ?? '',
      created: root['created'] != null
          ? DateTime.tryParse(root['created'] as String)
          : null,
      status: root['status'] as String? ?? '',
      statusDisplay: root['status_display'] as String? ?? '',
      statusHistory: historyList,
      canCancel: root['can_cancel'] as bool? ?? false,
      address: address,
      paymentMethodDisplay: root['payment_method_display'] as String? ?? 'Cash on delivery',
      pricing: OrderPricingEntity(
        subtotal: subtotal,
        productSavings: savings,
        voucherDiscount: discount,
        deliveryFee: delivery,
        total: total,
      ),
      items: allItems,
      itemCount: root['item_count'] as int? ?? allItems.length,
    );
  }

  static double _parseDouble(dynamic raw) {
    if (raw is num) return raw.toDouble();
    if (raw is String) return double.tryParse(raw) ?? 0.0;
    return 0.0;
  }

  OrderDetailEntity toEntity() {
    return OrderDetailEntity(
      orderNumber: orderNumber,
      created: created,
      status: OrderStatus.fromApi(status),
      statusDisplay: statusDisplay,
      statusHistory: statusHistory.map((e) => e.toEntity()).toList(),
      canCancel: canCancel,
      address: address,
      paymentMethodDisplay: paymentMethodDisplay,
      pricing: pricing,
      items: items.map((e) => e.toEntity()).toList(),
      itemCount: itemCount,
    );
  }

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
