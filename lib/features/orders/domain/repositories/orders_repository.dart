import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/orders/domain/entities/order_detail_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/orders_page_entity.dart';

/// Abstract contract for order data operations.
abstract interface class OrdersRepository {
  /// Fetches the first page of the user's orders from `orders/`.
  Future<ApiResult<OrdersPageEntity>> getOrders();

  /// Fetches the details of a specific order from `orders/$orderNumber/`.
  Future<ApiResult<OrderDetailEntity>> getOrderDetail(String orderNumber);
}
