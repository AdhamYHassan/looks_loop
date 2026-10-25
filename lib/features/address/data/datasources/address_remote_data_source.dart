import 'package:looks_loop/core/network/api_endpoints.dart';
import 'package:looks_loop/core/network/inetwork_helper.dart';
import 'package:looks_loop/features/address/data/models/address_model.dart';
import 'package:looks_loop/features/address/data/models/add_address_request_model.dart';
import 'package:looks_loop/features/address/data/models/province_model.dart';

/// Contract for remote network operations for addresses and provinces.
abstract interface class AddressRemoteDataSource {
  Future<List<AddressModel>> getAddresses();
  Future<AddressModel> addAddress(AddAddressRequestModel request);
  Future<List<ProvinceModel>> getProvinces();
}

/// Implementation using [InetworkHelper] for API requests.
class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final InetworkHelper _networkHelper;

  const AddressRemoteDataSourceImpl(this._networkHelper);

  @override
  Future<List<AddressModel>> getAddresses() async {
    final response = await _networkHelper.get(ApiEndpoints.addresses);
    final raw = response.data;
    final list = raw is Map<String, dynamic> && raw['data'] is List
        ? raw['data'] as List<dynamic>
        : (raw is List ? raw : const []);
    return list
        .whereType<Map<String, dynamic>>()
        .map(AddressModel.fromJson)
        .toList();
  }

  @override
  Future<AddressModel> addAddress(AddAddressRequestModel request) async {
    final response = await _networkHelper.post(
      ApiEndpoints.addresses,
      data: request.toJson(),
    );
    final raw = response.data;
    final map =
        raw is Map<String, dynamic> && raw['data'] is Map<String, dynamic>
            ? raw['data'] as Map<String, dynamic>
            : (raw as Map<String, dynamic>);
    return AddressModel.fromJson(map);
  }

  @override
  Future<List<ProvinceModel>> getProvinces() async {
    final response = await _networkHelper.get(ApiEndpoints.provincesNested);
    final raw = response.data;
    final list = raw is Map<String, dynamic> && raw['data'] is List
        ? raw['data'] as List<dynamic>
        : (raw is List ? raw : const []);
    return list
        .whereType<Map<String, dynamic>>()
        .map(ProvinceModel.fromJson)
        .toList();
  }
}
