import 'package:hive/hive.dart';
import 'package:looks_loop/features/address/data/models/address_model.dart';
import 'package:looks_loop/features/address/data/models/province_model.dart';

/// Contract for local storage of address & provinces data using Hive.
abstract interface class AddressLocalDataSource {
  Future<List<AddressModel>?> getCachedAddresses();
  Future<void> cacheAddresses(List<AddressModel> addresses);
  Future<List<ProvinceModel>?> getCachedProvinces();
  Future<void> cacheProvinces(List<ProvinceModel> provinces);
  Future<void> clearCache();
}

/// Implementation using raw Hive key-value map storage without code generation.
class AddressLocalDataSourceImpl implements AddressLocalDataSource {
  static const String boxName = 'address_cache_box';
  static const String _addressesKey = 'cached_addresses';
  static const String _provincesKey = 'cached_provinces';

  final Box<dynamic> _box;

  const AddressLocalDataSourceImpl(this._box);

  @override
  Future<List<AddressModel>?> getCachedAddresses() async {
    final rawData = _box.get(_addressesKey);
    if (rawData == null || rawData is! List) return null;
    return rawData
        .whereType<Map>()
        .map((e) => AddressModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> cacheAddresses(List<AddressModel> addresses) async {
    final serialized = addresses.map((e) => e.toJson()).toList();
    await _box.put(_addressesKey, serialized);
  }

  @override
  Future<List<ProvinceModel>?> getCachedProvinces() async {
    final rawData = _box.get(_provincesKey);
    if (rawData == null || rawData is! List) return null;
    return rawData
        .whereType<Map>()
        .map((e) => ProvinceModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> cacheProvinces(List<ProvinceModel> provinces) async {
    final serialized = provinces.map((e) => e.toJson()).toList();
    await _box.put(_provincesKey, serialized);
  }

  @override
  Future<void> clearCache() async {
    await _box.delete(_addressesKey);
    await _box.delete(_provincesKey);
  }
}
