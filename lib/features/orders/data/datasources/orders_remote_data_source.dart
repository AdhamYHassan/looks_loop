import 'package:looks_loop/core/network/api_endpoints.dart';
import 'package:looks_loop/core/network/inetwork_helper.dart';
import 'package:looks_loop/features/orders/data/models/order_detail_model.dart';
import 'package:looks_loop/features/orders/data/models/orders_page_model.dart';

abstract interface class OrdersRemoteDataSource {
  Future<OrdersPageModel> getOrders();
  Future<OrderDetailModel> getOrderDetail(String orderNumber);
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
    final response = await _networkHelper.get('${ApiEndpoints.orders}$orderNumber/');
    return OrderDetailModel.fromJson(response.data as Map<String, dynamic>);
  }
}
