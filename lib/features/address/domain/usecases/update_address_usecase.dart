import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/address/domain/entities/add_address_params.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/domain/repositories/address_repository.dart';

class UpdateAddressUseCase {
  final AddressRepository _repository;

  const UpdateAddressUseCase(this._repository);

  Future<ApiResult<AddressEntity>> call(int id, AddAddressParams params) async {
    return await _repository.updateAddress(id, params);
  }
}

