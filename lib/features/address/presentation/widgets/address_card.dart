import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/presentation/widgets/address_card_contact.dart';
import 'package:looks_loop/features/address/presentation/widgets/address_card_header.dart';
import 'package:looks_loop/features/address/presentation/widgets/address_undeliverable_notice.dart';

class AddressCard extends StatelessWidget {
  final AddressEntity address;
  final VoidCallback? onTap;

  const AddressCard({
    super.key,
    required this.address,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final canDeliver = address.canDeliver;
    final isDark = ColorManager.isDark(context);

    return Opacity(
      opacity: canDeliver ? 1.0 : 0.6,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: ColorManager.getCard(context),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: canDeliver
                ? (address.isDefault
                    ? ColorManager.olive.withValues(alpha: 0.5)
                    : ColorManager.getBorder(context))
                : (isDark
                    ? Colors.red.withValues(alpha: 0.3)
                    : Colors.red.withValues(alpha: 0.2)),
            width: address.isDefault && canDeliver ? 1.5 : 1.0,
          ),
        ),
        child: InkWell(
          onTap: canDeliver ? onTap : null,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddressCardHeader(address: address),
                const SizedBox(height: 10),
                Text(
                  address.formattedAddress,
                  style: TextStyles.font14Regular(context).copyWith(
                    color: ColorManager.getText(context),
                    height: 1.4,
                  ),
                ),
                if (address.landmark.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    '${'address.landmark'.tr()}: ${address.landmark}',
                    style: TextStyles.font12Regular(context).copyWith(
                      color: ColorManager.getTextMuted(context),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                AddressCardContact(address: address),
                if (!canDeliver) ...[
                  const SizedBox(height: 12),
                  const AddressUndeliverableNotice(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
