import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/address/domain/repositories/address_repository.dart';

class DeleteAddressUseCase {
  final AddressRepository _repository;

  const DeleteAddressUseCase(this._repository);

  Future<ApiResult<void>> call(int id) async {
    return await _repository.deleteAddress(id);
  }
}

