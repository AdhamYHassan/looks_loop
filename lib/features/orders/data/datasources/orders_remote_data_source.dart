import 'package:looks_loop/core/network/api_endpoints.dart';
import 'package:looks_loop/core/network/inetwork_helper.dart';
import 'package:looks_loop/features/orders/data/models/order_detail_model.dart';
import 'package:looks_loop/features/orders/data/models/orders_page_model.dart';

abstract interface class OrdersRemoteDataSource {
  Future<OrdersPageModel> getOrders();
  Future<OrderDetailModel> getOrderDetail(String orderNumber);
  Future<OrderDetailModel> cancelOrder(String orderNumber);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final InetworkHelper _networkHelper;

  const OrdersRemoteDataSourceImpl(this._networkHelper);

  @override
  Future<OrdersPageModel> getOrders() async {
    final response = await _networkHelper.get(ApiEndpoints.orders);
    return OrdersPageModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<OrderDetailModel> getOrderDetail(String orderNumber) async {
    final response =
        await _networkHelper.get('${ApiEndpoints.orders}$orderNumber/');
    return OrderDetailModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<OrderDetailModel> cancelOrder(String orderNumber) async {
    final response =
        await _networkHelper.post('${ApiEndpoints.orders}$orderNumber/cancel/');
    final data = response.data;
    if (data is Map<String, dynamic> &&
        (data.containsKey('order_number') || data.containsKey('data'))) {
      try {
        return OrderDetailModel.fromJson(data);
      } catch (_) {}
    }
    return getOrderDetail(orderNumber);
  }
}
