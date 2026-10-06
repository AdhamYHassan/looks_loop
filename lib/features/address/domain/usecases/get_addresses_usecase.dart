import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/domain/repositories/address_repository.dart';

/// Interactor for fetching user delivery addresses.
class GetAddressesUseCase {
  final AddressRepository _repository;

  const GetAddressesUseCase(this._repository);

  Future<ApiResult<List<AddressEntity>>> call() =>
      _repository.getAddresses();
}
