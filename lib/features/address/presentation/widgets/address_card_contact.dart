import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';

class AddressCardContact extends StatelessWidget {
  final AddressEntity address;

  const AddressCardContact({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.person_outline_rounded,
          size: 16,
          color: ColorManager.getTextMuted(context),
        ),
        const SizedBox(width: 6),
        Text(
          address.contactName,
          style: TextStyles.font13Medium(context).copyWith(
            color: ColorManager.getText(context),
          ),
        ),
        const SizedBox(width: 16),
        Icon(
          Icons.phone_outlined,
          size: 15,
          color: ColorManager.getTextMuted(context),
        ),
        const SizedBox(width: 6),
        Text(
          address.phone,
          style: TextStyles.font13Regular(context).copyWith(
            color: ColorManager.getTextMuted(context),
          ),
        ),
      ],
    );
  }
}
