import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/orders/domain/entities/order_detail_entity.dart';
import 'package:looks_loop/features/orders/domain/repositories/orders_repository.dart';

class CancelOrderUseCase {
  final OrdersRepository _repository;

  const CancelOrderUseCase(this._repository);

  Future<ApiResult<OrderDetailEntity>> call(String orderNumber) {
    return _repository.cancelOrder(orderNumber);
  }
}
