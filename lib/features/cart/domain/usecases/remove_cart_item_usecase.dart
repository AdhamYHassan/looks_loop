import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';
import 'package:looks_loop/features/cart/domain/repositories/cart_repository.dart';

class RemoveCartItemUseCase {
  final CartRepository _repository;

  const RemoveCartItemUseCase(this._repository);

  Future<ApiResult<CartEntity>> call(String itemId) {
    return _repository.removeItem(itemId);
  }
}
