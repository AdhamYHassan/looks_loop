import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/widgets/app_text_field.dart';

class AddAddressStreetFields extends StatelessWidget {
  final TextEditingController areaController;
  final TextEditingController streetController;

  const AddAddressStreetFields({
    super.key,
    required this.areaController,
    required this.streetController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: areaController,
          labelText: 'address.area'.tr(),
          hintText: 'e.g. Maadi',
          validator: (val) =>
              val == null || val.trim().isEmpty ? 'validation.required_field'.tr() : null,
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: streetController,
          labelText: 'address.street'.tr(),
          hintText: 'e.g. Road 9',
          validator: (val) =>
              val == null || val.trim().isEmpty ? 'validation.required_field'.tr() : null,
        ),
      ],
    );
  }
}
