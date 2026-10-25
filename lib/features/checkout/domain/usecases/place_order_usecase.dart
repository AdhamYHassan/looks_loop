import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/checkout/data/models/place_order_request_model.dart';
import 'package:looks_loop/features/checkout/domain/entities/placed_order_entity.dart';
import 'package:looks_loop/features/checkout/domain/repositories/checkout_repository.dart';

class PlaceOrderUseCase {
  final CheckoutRepository _repository;

  const PlaceOrderUseCase(this._repository);

  Future<ApiResult<PlacedOrderEntity>> call(PlaceOrderRequestModel params) {
    return _repository.placeOrder(params);
  }
}
