import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/widgets/app_text_field.dart';

class AddAddressContactFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;

  const AddAddressContactFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: firstNameController,
                labelText: 'address.first_name'.tr(),
                hintText: 'e.g. John',
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'validation.required_field'.tr() : null,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTextField(
                controller: lastNameController,
                labelText: 'address.last_name'.tr(),
                hintText: 'e.g. Doe',
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'validation.required_field'.tr() : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: phoneController,
          labelText: 'address.phone'.tr(),
          hintText: '01xxxxxxxxx',
          keyboardType: TextInputType.phone,
          validator: (val) =>
              val == null || val.trim().isEmpty ? 'validation.invalid_phone'.tr() : null,
        ),
      ],
    );
  }
}
