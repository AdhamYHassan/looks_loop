import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/address/domain/entities/city_entity.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';

class AddAddressLocationSelectors extends StatelessWidget {
  final List<ProvinceEntity> provinces;
  final ProvinceEntity? selectedProvince;
  final CityEntity? selectedCity;
  final ValueChanged<ProvinceEntity?> onProvinceChanged;
  final ValueChanged<CityEntity?> onCityChanged;

  const AddAddressLocationSelectors({
    super.key,
    required this.provinces,
    required this.selectedProvince,
    required this.selectedCity,
    required this.onProvinceChanged,
    required this.onCityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final availableCities = selectedProvince?.cities ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDropdown<ProvinceEntity>(
          context: context,
          label: 'address.province'.tr(),
          hint: 'address.select_province'.tr(),
          value: selectedProvince,
          items: provinces.map((p) {
            final name =
                context.locale.languageCode == 'ar' ? p.nameAr : p.nameEn;
            return DropdownMenuItem(
              value: p,
              child: Text(name.isNotEmpty ? name : p.name),
            );
          }).toList(),
          onChanged: onProvinceChanged,
        ),
        const SizedBox(height: 12),
        _buildDropdown<CityEntity>(
          context: context,
          label: 'address.city'.tr(),
          hint: 'address.select_city'.tr(),
          value: selectedCity,
          items: availableCities.map((c) {
            final name =
                context.locale.languageCode == 'ar' ? c.nameAr : c.nameEn;
            return DropdownMenuItem(
              value: c,
              child: Text(name.isNotEmpty ? name : c.name),
            );
          }).toList(),
          onChanged: selectedProvince != null ? onCityChanged : null,
        ),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required BuildContext context,
    required String label,
    required String hint,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.font12Medium(context).copyWith(
            color: ColorManager.getText(context),
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items,
          onChanged: onChanged,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyles.font13Regular(context).copyWith(
              color: ColorManager.getTextMuted(context),
            ),
            filled: true,
            fillColor: ColorManager.getCard(context),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorManager.getBorder(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorManager.getBorder(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: ColorManager.olive, width: 1.5),
            ),
          ),
          dropdownColor: ColorManager.getCard(context),
          validator: (val) =>
              val == null ? 'validation.required_field'.tr() : null,
        ),
      ],
    );
  }
}
