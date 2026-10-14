import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';
import 'package:looks_loop/features/cart/domain/repositories/cart_repository.dart';

class UpdateCartQuantityUseCase {
  final CartRepository _repository;

  const UpdateCartQuantityUseCase(this._repository);

  Future<ApiResult<CartEntity>> call({
    required String itemId,
    required int quantity,
  }) {
    return _repository.updateQuantity(
      itemId: itemId,
      quantity: quantity,
    );
  }
}
