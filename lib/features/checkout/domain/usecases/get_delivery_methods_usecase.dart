import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/checkout/domain/entities/delivery_method_entity.dart';
import 'package:looks_loop/features/checkout/domain/repositories/checkout_repository.dart';

class GetDeliveryMethodsUseCase {
  final CheckoutRepository _repository;

  const GetDeliveryMethodsUseCase(this._repository);

  Future<ApiResult<List<DeliveryMethodEntity>>> call(int provinceId) {
    return _repository.getDeliveryMethods(provinceId);
  }
}
