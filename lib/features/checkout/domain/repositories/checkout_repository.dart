import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/checkout/data/models/place_order_request_model.dart';
import 'package:looks_loop/features/checkout/domain/entities/delivery_method_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/payment_method_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/placed_order_entity.dart';

abstract interface class CheckoutRepository {
  Future<ApiResult<List<DeliveryMethodEntity>>> getDeliveryMethods(
      int provinceId);
  Future<ApiResult<List<PaymentMethodEntity>>> getPaymentMethods();
  Future<ApiResult<PlacedOrderEntity>> placeOrder(
      PlaceOrderRequestModel request);
}
