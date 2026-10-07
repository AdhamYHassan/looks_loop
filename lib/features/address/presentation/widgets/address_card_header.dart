import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';

class AddressCardHeader extends StatelessWidget {
  final AddressEntity address;

  const AddressCardHeader({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: ColorManager.olive.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            address.displayLabel.toUpperCase(),
            style: TextStyles.font11SemiBold(context).copyWith(
              color: ColorManager.olive,
              letterSpacing: 0.5,
            ),
          ),
        ),
        if (address.title.isNotEmpty && address.title != address.label) ...[
          const SizedBox(width: 8),
          Text(
            address.title,
            style: TextStyles.font14SemiBold(context).copyWith(
              color: ColorManager.getText(context),
            ),
          ),
        ],
        const Spacer(),
        if (address.isDefault)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: ColorManager.olive,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'address.default_badge'.tr(),
              style: TextStyles.font11SemiBold(context).copyWith(
                color: ColorManager.cream,
              ),
            ),
          ),
      ],
    );
  }
}
