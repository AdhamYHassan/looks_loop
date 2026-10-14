import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';
import 'package:looks_loop/features/cart/domain/repositories/cart_repository.dart';

class ApplyPromoCodeUseCase {
  final CartRepository _repository;

  const ApplyPromoCodeUseCase(this._repository);

  Future<ApiResult<CartEntity>> call(String promoCode) {
    return _repository.applyPromoCode(promoCode);
  }
}
