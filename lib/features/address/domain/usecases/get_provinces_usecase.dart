import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';
import 'package:looks_loop/features/address/domain/repositories/address_repository.dart';

/// Interactor for fetching Egypt provinces and cities with session cache.
class GetProvincesUseCase {
  final AddressRepository _repository;

  const GetProvincesUseCase(this._repository);

  Future<ApiResult<List<ProvinceEntity>>> call({
    bool forceRefresh = false,
  }) =>
      _repository.getProvinces(forceRefresh: forceRefresh);
}
