import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/orders/data/models/order_summary_model.dart';
import 'package:looks_loop/features/orders/domain/entities/orders_page_entity.dart';

/// DTO for the paginated `orders/` response, unwrapping the `data` envelope.
class OrdersPageModel extends Equatable {
  final int count;
  final String? next;
  final List<OrderSummaryModel> results;

  const OrdersPageModel({
    required this.count,
    required this.next,
    required this.results,
  });

  factory OrdersPageModel.fromJson(Map<String, dynamic> json) {
    final body = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;
    final rawResults = body['results'];

    return OrdersPageModel(
      count: body['count'] as int? ?? 0,
      next: body['next'] as String?,
      results: rawResults is List
          ? rawResults
              .whereType<Map<String, dynamic>>()
              .map(OrderSummaryModel.fromJson)
              .toList()
          : [],
    );
  }

  OrdersPageEntity toEntity() => OrdersPageEntity(
        count: count,
        hasNext: next != null,
        orders: results.map((m) => m.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [count, next, results];
}
