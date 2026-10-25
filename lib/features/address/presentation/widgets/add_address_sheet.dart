import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/domain/entities/city_entity.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_cubit.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_building_details.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_contact_fields.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_default_switch.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_header.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_label_selector.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_location_section.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_street_fields.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_submit_button.dart';
import 'package:looks_loop/features/address/presentation/widgets/address_form_controllers.dart';

class AddAddressSheet extends StatefulWidget {
  final AddressEntity? initialAddress;

  const AddAddressSheet({super.key, this.initialAddress});

  @override
  State<AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<AddAddressSheet> {
  final _formKey = GlobalKey<FormState>();

  late String _label;
  late bool _isDefault;
  late final AddressFormControllers _controllers;
  ProvinceEntity? _selectedProvince;
  CityEntity? _selectedCity;

  @override
  void initState() {
    super.initState();
    context.read<AddressCubit>().loadProvinces();
    final addr = widget.initialAddress;
    _label = addr?.label ?? 'home';
    _isDefault = addr?.isDefault ?? true;
    _controllers = AddressFormControllers.fromAddress(addr);
  }

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate() || _selectedCity == null) return;

    final params = _controllers.toParams(
      label: _label,
      cityId: _selectedCity!.id,
      isDefault: _isDefault,
    );

    final success = await context.read<AddressCubit>().addAddress(params);
    if (success && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.90;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: ColorManager.getBackground(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: true,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AddAddressHeader(
                  title: widget.initialAddress != null ? 'Edit Address' : null,
                ),
                const SizedBox(height: 16),
                AddAddressLabelSelector(
                  selectedLabel: _label,
                  onLabelChanged: (val) => setState(() => _label = val),
                ),
                const SizedBox(height: 14),
                AddAddressContactFields(
                  firstNameController: _controllers.first,
                  lastNameController: _controllers.last,
                  phoneController: _controllers.phone,
                ),
                const SizedBox(height: 14),
                AddAddressLocationSection(
                  initialCityId: widget.initialAddress?.cityId,
                  selectedProvince: _selectedProvince,
                  selectedCity: _selectedCity,
                  onProvinceChanged: (p) => setState(() {
                    _selectedProvince = p;
                    _selectedCity = null;
                  }),
                  onCityChanged: (c) => setState(() => _selectedCity = c),
                ),
                const SizedBox(height: 14),
                AddAddressStreetFields(
                  areaController: _controllers.area,
                  streetController: _controllers.street,
                ),
                const SizedBox(height: 14),
                AddAddressBuildingDetails(
                  buildingController: _controllers.building,
                  floorController: _controllers.floor,
                  apartmentController: _controllers.apt,
                  landmarkController: _controllers.landmark,
                ),
                const SizedBox(height: 14),
                AddAddressDefaultSwitch(
                  value: _isDefault,
                  onChanged: (val) => setState(() => _isDefault = val),
                ),
                const SizedBox(height: 20),
                AddAddressSubmitButton(onSubmit: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
