import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/orders/domain/entities/orders_page_entity.dart';
import 'package:looks_loop/features/orders/domain/repositories/orders_repository.dart';

/// Interactor for fetching the user's orders.
class GetOrdersUseCase {
  final OrdersRepository _repository;

  const GetOrdersUseCase(this._repository);

  Future<ApiResult<OrdersPageEntity>> call() => _repository.getOrders();
}
