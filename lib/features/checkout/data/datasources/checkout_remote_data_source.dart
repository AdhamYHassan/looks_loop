import 'package:looks_loop/core/network/api_endpoints.dart';
import 'package:looks_loop/core/network/inetwork_helper.dart';
import 'package:looks_loop/features/checkout/data/models/delivery_method_model.dart';
import 'package:looks_loop/features/checkout/data/models/payment_method_model.dart';
import 'package:looks_loop/features/checkout/data/models/place_order_request_model.dart';
import 'package:looks_loop/features/checkout/data/models/place_order_response_model.dart';

abstract interface class CheckoutRemoteDataSource {
  Future<List<DeliveryMethodModel>> getDeliveryMethods(int provinceId);
  Future<List<PaymentMethodModel>> getPaymentMethods();
  Future<PlaceOrderResponseModel> placeOrder(PlaceOrderRequestModel request);
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final InetworkHelper _networkHelper;

  const CheckoutRemoteDataSourceImpl(this._networkHelper);

  @override
  Future<List<DeliveryMethodModel>> getDeliveryMethods(int provinceId) async {
    final response = await _networkHelper.get(
      ApiEndpoints.deliveryMethods,
      queryParameters: {'province': provinceId},
    );

    final rawData = response.data;
    final list = (rawData is Map<String, dynamic> ? rawData['data'] : rawData)
            as List<dynamic>? ??
        [];

    return list
        .map((e) => DeliveryMethodModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    final response = await _networkHelper.get(ApiEndpoints.paymentMethods);

    final rawData = response.data;
    final list = (rawData is Map<String, dynamic> ? rawData['data'] : rawData)
            as List<dynamic>? ??
        [];

    return list
        .map((e) => PaymentMethodModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PlaceOrderResponseModel> placeOrder(
      PlaceOrderRequestModel request) async {
    final response = await _networkHelper.post(
      ApiEndpoints.orders,
      data: request.toJson(),
    );

    return PlaceOrderResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
