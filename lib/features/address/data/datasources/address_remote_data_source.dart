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
    final data = response.data as List<dynamic>;
    return data
        .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<AddressModel> addAddress(AddAddressRequestModel request) async {
    final response = await _networkHelper.post(
      ApiEndpoints.addresses,
      data: request.toJson(),
    );
    return AddressModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<ProvinceModel>> getProvinces() async {
    final response = await _networkHelper.get(ApiEndpoints.provincesNested);
    final data = response.data as List<dynamic>;
    return data
        .map((e) => ProvinceModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
