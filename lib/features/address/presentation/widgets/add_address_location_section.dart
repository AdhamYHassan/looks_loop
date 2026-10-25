import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/features/address/domain/entities/city_entity.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_cubit.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_state.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_location_selectors.dart';

class AddAddressLocationSection extends StatelessWidget {
  final int? initialCityId;
  final ProvinceEntity? selectedProvince;
  final CityEntity? selectedCity;
  final ValueChanged<ProvinceEntity?> onProvinceChanged;
  final ValueChanged<CityEntity?> onCityChanged;

  const AddAddressLocationSection({
    super.key,
    required this.initialCityId,
    required this.selectedProvince,
    required this.selectedCity,
    required this.onProvinceChanged,
    required this.onCityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        final provinces = switch (state) {
          AddressLoaded(:final provinces) => provinces,
          AddressActionSuccess(:final provinces) => provinces,
          AddressError(:final provinces) => provinces,
          _ => <ProvinceEntity>[],
        };

        var currentProvince = selectedProvince;
        var currentCity = selectedCity;

        if (currentCity == null && initialCityId != null) {
          for (final p in provinces) {
            for (final c in p.cities) {
              if (c.id == initialCityId) {
                currentProvince ??= p;
                currentCity = c;
                break;
              }
            }
            if (currentCity != null) break;
          }
        }

        return AddAddressLocationSelectors(
          provinces: provinces,
          selectedProvince: currentProvince,
          selectedCity: currentCity,
          onProvinceChanged: onProvinceChanged,
          onCityChanged: onCityChanged,
        );
      },
    );
  }
}
