import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';

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
                    ? ColorManager.olive.withValues(alpha: 0.4)
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
                _buildHeader(context),
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
                const SizedBox(height: 10),
                _buildContactInfo(context),
                if (!canDeliver) ...[
                  const SizedBox(height: 12),
                  _buildUndeliverableNotice(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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

  Widget _buildContactInfo(BuildContext context) {
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

  Widget _buildUndeliverableNotice(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, size: 16, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'address.cannot_deliver'.tr(),
              style: TextStyles.font12Regular(context).copyWith(
                color: Colors.red.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
