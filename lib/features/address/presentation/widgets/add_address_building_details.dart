import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/widgets/app_text_field.dart';

class AddAddressBuildingDetails extends StatelessWidget {
  final TextEditingController buildingController;
  final TextEditingController floorController;
  final TextEditingController apartmentController;
  final TextEditingController landmarkController;

  const AddAddressBuildingDetails({
    super.key,
    required this.buildingController,
    required this.floorController,
    required this.apartmentController,
    required this.landmarkController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: buildingController,
                labelText: 'address.building'.tr(),
                hintText: 'e.g. 12B',
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'validation.required_field'.tr() : null,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTextField(
                controller: floorController,
                labelText: 'address.floor'.tr(),
                hintText: 'e.g. 3',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppTextField(
                controller: apartmentController,
                labelText: 'address.apartment'.tr(),
                hintText: 'e.g. 5',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: landmarkController,
          labelText: 'address.landmark'.tr(),
          hintText: 'e.g. Near Grand Mosque',
        ),
      ],
    );
  }
}
