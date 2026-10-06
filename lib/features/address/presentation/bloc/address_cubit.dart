import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/domain/entities/add_address_params.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';
import 'package:looks_loop/features/address/domain/usecases/add_address_usecase.dart';
import 'package:looks_loop/features/address/domain/usecases/get_addresses_usecase.dart';
import 'package:looks_loop/features/address/domain/usecases/get_provinces_usecase.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final GetAddressesUseCase _getAddressesUseCase;
  final AddAddressUseCase _addAddressUseCase;
  final GetProvincesUseCase _getProvincesUseCase;

  List<AddressEntity> _currentAddresses = [];
  List<ProvinceEntity> _currentProvinces = [];

  AddressCubit(
    this._getAddressesUseCase,
    this._addAddressUseCase,
    this._getProvincesUseCase,
  ) : super(const AddressInitial());

  Future<void> loadAddresses() async {
    emit(const AddressLoading());
    final result = await _getAddressesUseCase();

    switch (result) {
      case ApiSuccess<List<AddressEntity>>(:final data):
        _currentAddresses = data;
        emit(AddressLoaded(
          addresses: _currentAddresses,
          provinces: _currentProvinces,
        ));
      case ApiFailure<List<AddressEntity>>(:final failure):
        emit(AddressError(
          message: failure.message,
          addresses: _currentAddresses,
          provinces: _currentProvinces,
        ));
    }
  }

  Future<void> loadProvinces({bool forceRefresh = false}) async {
    if (_currentProvinces.isNotEmpty && !forceRefresh) return;
    final result = await _getProvincesUseCase(forceRefresh: forceRefresh);

    switch (result) {
      case ApiSuccess<List<ProvinceEntity>>(:final data):
        _currentProvinces = data;
        if (state is AddressLoaded) {
          emit((state as AddressLoaded).copyWith(provinces: _currentProvinces));
        }
      case ApiFailure<List<ProvinceEntity>>():
        break;
    }
  }

  Future<bool> addAddress(AddAddressParams params) async {
    final currentState = state;
    if (currentState is AddressLoaded) {
      emit(currentState.copyWith(isSaving: true));
    }

    final result = await _addAddressUseCase(params);

    switch (result) {
      case ApiSuccess<AddressEntity>(:final data):
        _currentAddresses = [data, ..._currentAddresses];
        emit(AddressActionSuccess(
          message: 'address.address_saved_success',
          addresses: _currentAddresses,
          provinces: _currentProvinces,
        ));
        emit(AddressLoaded(
          addresses: _currentAddresses,
          provinces: _currentProvinces,
        ));
        return true;
      case ApiFailure<AddressEntity>(:final failure):
        if (currentState is AddressLoaded) {
          emit(currentState.copyWith(isSaving: false));
        }
        emit(AddressError(
          message: failure.message,
          addresses: _currentAddresses,
          provinces: _currentProvinces,
        ));
        return false;
    }
  }
}
