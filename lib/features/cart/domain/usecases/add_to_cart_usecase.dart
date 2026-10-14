import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/cart/domain/entities/add_to_cart_params.dart';
import 'package:looks_loop/features/cart/domain/repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository _repository;

  const AddToCartUseCase(this._repository);

  Future<ApiResult<void>> call(AddToCartParams params) {
    return _repository.addToCart(params);
  }
}
