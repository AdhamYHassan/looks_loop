import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/address/domain/entities/add_address_params.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/domain/repositories/address_repository.dart';

/// Interactor for adding a new user delivery address.
class AddAddressUseCase {
  final AddressRepository _repository;

  const AddAddressUseCase(this._repository);

  Future<ApiResult<AddressEntity>> call(AddAddressParams params) =>
      _repository.addAddress(params);
}
