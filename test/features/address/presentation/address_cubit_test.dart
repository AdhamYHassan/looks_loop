import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/failure.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/domain/entities/add_address_params.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';
import 'package:looks_loop/features/address/domain/repositories/address_repository.dart';
import 'package:looks_loop/features/address/domain/usecases/add_address_usecase.dart';
import 'package:looks_loop/features/address/domain/usecases/get_addresses_usecase.dart';
import 'package:looks_loop/features/address/domain/usecases/get_provinces_usecase.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_cubit.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_state.dart';

class FakeAddressRepository implements AddressRepository {
  ApiResult<List<AddressEntity>> Function()? onGetAddresses;
  ApiResult<AddressEntity> Function(AddAddressParams)? onAddAddress;
  ApiResult<List<ProvinceEntity>> Function({bool forceRefresh})? onGetProvinces;

  @override
  Future<ApiResult<List<AddressEntity>>> getAddresses() async =>
      onGetAddresses!();

  @override
  Future<ApiResult<AddressEntity>> addAddress(AddAddressParams params) async =>
      onAddAddress!(params);

  @override
  Future<ApiResult<List<ProvinceEntity>>> getProvinces({
    bool forceRefresh = false,
  }) async =>
      onGetProvinces != null
          ? onGetProvinces!(forceRefresh: forceRefresh)
          : const ApiSuccess([]);
}

void main() {
  const dummyAddress = AddressEntity(
    id: 1,
    label: 'home',
    title: 'Home',
    displayLabel: 'Home',
    firstName: 'Sara',
    lastName: 'Ahmed',
    fullName: 'Sara Ahmed',
    phone: '01123456789',
    cityId: 2,
    cityName: 'Cairo',
    area: 'Zamalek',
    street: '26th of July',
    building: '5',
    floor: '2',
    apartment: '4',
    landmark: '',
    isDefault: true,
    location: '',
    singleLine: 'Zamalek, 26th of July Bldg 5',
    canDeliver: true,
  );

  test('AddressCubit emits [AddressLoading, AddressLoaded] on successful fetch', () async {
    final repo = FakeAddressRepository()
      ..onGetAddresses = () => const ApiSuccess([dummyAddress]);

    final cubit = AddressCubit(
      GetAddressesUseCase(repo),
      AddAddressUseCase(repo),
      GetProvincesUseCase(repo),
    );

    final expectedStates = [
      const AddressLoading(),
      const AddressLoaded(addresses: [dummyAddress]),
    ];

    expectLater(cubit.stream, emitsInOrder(expectedStates));

    await cubit.loadAddresses();
  });

  test('AddressCubit emits [AddressLoading, AddressError] on failure', () async {
    final repo = FakeAddressRepository()
      ..onGetAddresses = () => const ApiFailure(ServerFailure('Server Error'));

    final cubit = AddressCubit(
      GetAddressesUseCase(repo),
      AddAddressUseCase(repo),
      GetProvincesUseCase(repo),
    );

    final expectedStates = [
      const AddressLoading(),
      const AddressError(message: 'Server Error'),
    ];

    expectLater(cubit.stream, emitsInOrder(expectedStates));

    await cubit.loadAddresses();
  });
}
