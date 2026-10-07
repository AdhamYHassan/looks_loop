import 'package:looks_loop/core/network/network_exceptions.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/orders/data/datasources/orders_remote_data_source.dart';
import 'package:looks_loop/features/orders/domain/entities/order_detail_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/orders_page_entity.dart';
import 'package:looks_loop/features/orders/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource _remoteDataSource;

  const OrdersRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<OrdersPageEntity>> getOrders() async {
    try {
      final model = await _remoteDataSource.getOrders();
      return ApiSuccess(model.toEntity());
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }

  @override
  Future<ApiResult<OrderDetailEntity>> getOrderDetail(String orderNumber) async {
    try {
      final model = await _remoteDataSource.getOrderDetail(orderNumber);
      return ApiSuccess(model.toEntity());
    } catch (e) {
      return ApiFailure(NetworkExceptions.getFailure(e));
    }
  }
}
