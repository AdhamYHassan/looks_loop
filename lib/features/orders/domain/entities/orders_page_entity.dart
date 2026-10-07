import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/orders/domain/entities/order_summary_entity.dart';

/// One page of the paginated `orders/` response.
class OrdersPageEntity extends Equatable {
  final int count;
  final bool hasNext;
  final List<OrderSummaryEntity> orders;

  const OrdersPageEntity({
    required this.count,
    required this.hasNext,
    required this.orders,
  });

  @override
  List<Object?> get props => [count, hasNext, orders];
}
