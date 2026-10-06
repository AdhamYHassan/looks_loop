import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class AddAddressLabelSelector extends StatelessWidget {
  final String selectedLabel;
  final ValueChanged<String> onLabelChanged;

  const AddAddressLabelSelector({
    super.key,
    required this.selectedLabel,
    required this.onLabelChanged,
  });

  @override
  Widget build(BuildContext context) {
    final labels = [
      {'key': 'home', 'label': 'address.home'.tr(), 'icon': Icons.home_outlined},
      {'key': 'work', 'label': 'address.work'.tr(), 'icon': Icons.business_outlined},
      {'key': 'other', 'label': 'address.other'.tr(), 'icon': Icons.location_on_outlined},
    ];

    return Row(
      children: labels.map((item) {
        final key = item['key'] as String;
        final label = item['label'] as String;
        final icon = item['icon'] as IconData;
        final isSelected = selectedLabel == key;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: InkWell(
              onTap: () => onLabelChanged(key),
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorManager.olive
                      : ColorManager.getCard(context),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? ColorManager.olive
                        : ColorManager.getBorder(context),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 16,
                      color: isSelected
                          ? ColorManager.cream
                          : ColorManager.getTextMuted(context),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: TextStyles.font12Medium(context).copyWith(
                        color: isSelected
                            ? ColorManager.cream
                            : ColorManager.getText(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
