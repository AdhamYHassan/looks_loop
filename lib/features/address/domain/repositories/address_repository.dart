import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/domain/entities/add_address_params.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';

/// Abstract contract for address and provinces data operations.
abstract interface class AddressRepository {
  /// Fetches the user's saved delivery addresses from `me/addresses/`.
  Future<ApiResult<List<AddressEntity>>> getAddresses();

  /// Adds a new delivery address via `POST me/addresses/`.
  Future<ApiResult<AddressEntity>> addAddress(AddAddressParams params);

  /// Fetches nested provinces and cities from `provinces/nested/?country=1`
  /// with session-level in-memory cache.
  Future<ApiResult<List<ProvinceEntity>>> getProvinces({
    bool forceRefresh = false,
  });
}
