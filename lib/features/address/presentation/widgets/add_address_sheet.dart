import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/address/domain/entities/add_address_params.dart';
import 'package:looks_loop/features/address/domain/entities/city_entity.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_cubit.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_state.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_building_details.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_contact_fields.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_header.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_label_selector.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_location_selectors.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_street_fields.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_submit_button.dart';

class AddAddressSheet extends StatefulWidget {
  const AddAddressSheet({super.key});

  @override
  State<AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<AddAddressSheet> {
  final _formKey = GlobalKey<FormState>();

  String _label = 'home';
  ProvinceEntity? _selectedProvince;
  CityEntity? _selectedCity;
  bool _isDefault = true;

  late final TextEditingController _firstCtrl;
  late final TextEditingController _lastCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _areaCtrl;
  late final TextEditingController _streetCtrl;
  late final TextEditingController _buildingCtrl;
  late final TextEditingController _floorCtrl;
  late final TextEditingController _aptCtrl;
  late final TextEditingController _landmarkCtrl;

  @override
  void initState() {
    super.initState();
    context.read<AddressCubit>().loadProvinces();
    _firstCtrl = TextEditingController();
    _lastCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _areaCtrl = TextEditingController();
    _streetCtrl = TextEditingController();
    _buildingCtrl = TextEditingController();
    _floorCtrl = TextEditingController();
    _aptCtrl = TextEditingController();
    _landmarkCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _firstCtrl.dispose();
    _lastCtrl.dispose();
    _phoneCtrl.dispose();
    _areaCtrl.dispose();
    _streetCtrl.dispose();
    _buildingCtrl.dispose();
    _floorCtrl.dispose();
    _aptCtrl.dispose();
    _landmarkCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate() || _selectedCity == null) return;

    final params = AddAddressParams(
      label: _label,
      title: _label,
      firstName: _firstCtrl.text.trim(),
      lastName: _lastCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      cityId: _selectedCity!.id,
      area: _areaCtrl.text.trim(),
      street: _streetCtrl.text.trim(),
      building: _buildingCtrl.text.trim(),
      floor: _floorCtrl.text.trim(),
      apartment: _aptCtrl.text.trim(),
      landmark: _landmarkCtrl.text.trim(),
      isDefault: _isDefault,
    );

    final success = await context.read<AddressCubit>().addAddress(params);
    if (success && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: ColorManager.getBackground(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const AddAddressHeader(),
              const SizedBox(height: 16),
              AddAddressLabelSelector(
                selectedLabel: _label,
                onLabelChanged: (val) => setState(() => _label = val),
              ),
              const SizedBox(height: 14),
              AddAddressContactFields(
                firstNameController: _firstCtrl,
                lastNameController: _lastCtrl,
                phoneController: _phoneCtrl,
              ),
              const SizedBox(height: 14),
              BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  final provinces = switch (state) {
                    AddressLoaded(:final provinces) => provinces,
                    AddressActionSuccess(:final provinces) => provinces,
                    AddressError(:final provinces) => provinces,
                    _ => <ProvinceEntity>[],
                  };

                  return AddAddressLocationSelectors(
                    provinces: provinces,
                    selectedProvince: _selectedProvince,
                    selectedCity: _selectedCity,
                    onProvinceChanged: (p) => setState(() {
                      _selectedProvince = p;
                      _selectedCity = null;
                    }),
                    onCityChanged: (c) => setState(() => _selectedCity = c),
                  );
                },
              ),
              const SizedBox(height: 14),
              AddAddressStreetFields(
                areaController: _areaCtrl,
                streetController: _streetCtrl,
              ),
              const SizedBox(height: 14),
              AddAddressBuildingDetails(
                buildingController: _buildingCtrl,
                floorController: _floorCtrl,
                apartmentController: _aptCtrl,
                landmarkController: _landmarkCtrl,
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'address.set_as_default'.tr(),
                    style: TextStyles.font14Medium(context),
                  ),
                  Switch.adaptive(
                    value: _isDefault,
                    activeTrackColor: ColorManager.olive,
                    onChanged: (val) => setState(() => _isDefault = val),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AddAddressSubmitButton(onSubmit: _submit),
            ],
          ),
        ),
      ),
    );
  }
}
