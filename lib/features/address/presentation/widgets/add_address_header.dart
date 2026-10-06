import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/styles.dart';

class AddAddressHeader extends StatelessWidget {
  const AddAddressHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'address.add_new'.tr(),
          style: TextStyles.font18SemiBold(context),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
        ),
      ],
    );
  }
}
