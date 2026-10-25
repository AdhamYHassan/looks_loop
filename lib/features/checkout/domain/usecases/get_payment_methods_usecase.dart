import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/checkout/domain/entities/payment_method_entity.dart';
import 'package:looks_loop/features/checkout/domain/repositories/checkout_repository.dart';

class GetPaymentMethodsUseCase {
  final CheckoutRepository _repository;

  const GetPaymentMethodsUseCase(this._repository);

  Future<ApiResult<List<PaymentMethodEntity>>> call() {
    return _repository.getPaymentMethods();
  }
}
