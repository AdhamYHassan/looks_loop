import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class AddAddressDefaultSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AddAddressDefaultSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'address.set_as_default'.tr(),
            style: TextStyles.font14Medium(context),
          ),
        ),
        Switch.adaptive(
          value: value,
          activeTrackColor: ColorManager.olive,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
