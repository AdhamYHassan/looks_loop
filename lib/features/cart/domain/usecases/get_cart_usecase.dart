import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';
import 'package:looks_loop/features/cart/domain/repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository _repository;

  const GetCartUseCase(this._repository);

  Future<ApiResult<CartEntity>> call() {
    return _repository.getCart();
  }
}
