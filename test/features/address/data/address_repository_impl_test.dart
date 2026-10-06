import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/address/data/datasources/address_local_data_source.dart';
import 'package:looks_loop/features/address/data/datasources/address_remote_data_source.dart';
import 'package:looks_loop/features/address/data/models/address_model.dart';
import 'package:looks_loop/features/address/data/models/add_address_request_model.dart';
import 'package:looks_loop/features/address/data/models/province_model.dart';
import 'package:looks_loop/features/address/data/repositories/address_repository_impl.dart';
import 'package:looks_loop/features/address/domain/entities/add_address_params.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';

class FakeRemoteDataSource implements AddressRemoteDataSource {
  List<AddressModel> Function()? onGetAddresses;
  AddressModel Function(AddAddressRequestModel)? onAddAddress;
  List<ProvinceModel> Function()? onGetProvinces;

  @override
  Future<List<AddressModel>> getAddresses() async => onGetAddresses!();

  @override
  Future<AddressModel> addAddress(AddAddressRequestModel req) async =>
      onAddAddress!(req);

  @override
  Future<List<ProvinceModel>> getProvinces() async => onGetProvinces!();
}

class FakeLocalDataSource implements AddressLocalDataSource {
  List<AddressModel>? cachedAddresses;
  List<ProvinceModel>? cachedProvinces;

  @override
  Future<List<AddressModel>?> getCachedAddresses() async => cachedAddresses;

  @override
  Future<void> cacheAddresses(List<AddressModel> addresses) async {
    cachedAddresses = addresses;
  }

  @override
  Future<List<ProvinceModel>?> getCachedProvinces() async => cachedProvinces;

  @override
  Future<void> cacheProvinces(List<ProvinceModel> provinces) async {
    cachedProvinces = provinces;
  }

  @override
  Future<void> clearCache() async {
    cachedAddresses = null;
    cachedProvinces = null;
  }
}

void main() {
  const dummyAddressModel = AddressModel(
    id: 1,
    label: 'home',
    title: 'My Apartment',
    displayLabel: 'Home',
    firstName: 'Ahmed',
    lastName: 'Ali',
    fullName: 'Ahmed Ali',
    phone: '01012345678',
    cityId: 1,
    cityName: 'Alexandria',
    area: 'Smouha',
    street: 'Victor Emanuel',
    building: '10',
    floor: '4',
    apartment: '12',
    landmark: 'Near Club',
    isDefault: true,
    location: '',
    singleLine: 'Smouha, Victor Emanuel Bldg 10',
    canDeliver: true,
  );

  test('AddressRepositoryImpl getAddresses fetches remote and saves to local cache', () async {
    final remote = FakeRemoteDataSource()..onGetAddresses = () => [dummyAddressModel];
    final local = FakeLocalDataSource();
    final repo = AddressRepositoryImpl(remote, local);

    final result = await repo.getAddresses();

    expect(result, isA<ApiSuccess<List<AddressEntity>>>());
    expect((result as ApiSuccess<List<AddressEntity>>).data.length, 1);
    expect(local.cachedAddresses, [dummyAddressModel]);
  });

  test('AddressRepositoryImpl addAddress calls remote and updates cache', () async {
    final remote = FakeRemoteDataSource()
      ..onAddAddress = (_) => dummyAddressModel;
    final local = FakeLocalDataSource();
    final repo = AddressRepositoryImpl(remote, local);

    const params = AddAddressParams(
      label: 'home',
      title: 'My Apartment',
      firstName: 'Ahmed',
      lastName: 'Ali',
      phone: '01012345678',
      cityId: 1,
      area: 'Smouha',
      street: 'Victor Emanuel',
      building: '10',
      floor: '4',
      apartment: '12',
      landmark: 'Near Club',
    );

    final result = await repo.addAddress(params);

    expect(result, isA<ApiSuccess<AddressEntity>>());
    expect((result as ApiSuccess<AddressEntity>).data.title, 'My Apartment');
    expect(local.cachedAddresses?.length, 1);
  });

  test('AddressRepositoryImpl getProvinces returns memory cache on repeated calls', () async {
    int remoteCallCount = 0;
    final remote = FakeRemoteDataSource()
      ..onGetProvinces = () {
        remoteCallCount++;
        return [
          const ProvinceModel(
            id: 1,
            countryId: 1,
            name: 'Alexandria',
            nameEn: 'Alexandria',
            nameAr: 'الإسكندرية',
            cities: [],
          ),
        ];
      };
    final local = FakeLocalDataSource();
    final repo = AddressRepositoryImpl(remote, local);

    final first = await repo.getProvinces();
    final second = await repo.getProvinces();

    expect(first, isA<ApiSuccess<List<ProvinceEntity>>>());
    expect(second, isA<ApiSuccess<List<ProvinceEntity>>>());
    expect(remoteCallCount, 1); // Only 1 network call made due to session in-memory cache
  });
}
