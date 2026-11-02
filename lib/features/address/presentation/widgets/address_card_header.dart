import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AddressCardHeader extends StatelessWidget {
  final AddressEntity address;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AddressCardHeader({
    super.key,
    required this.address,
    this.onEdit,
    this.onDelete,
  });

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
        if (onEdit != null || onDelete != null) ...[
          const SizedBox(width: 4),
          PopupMenuButton<String>(
            icon: Icon(
              LucideIcons.moreVertical,
              size: 18,
              color: ColorManager.getTextMuted(context),
            ),
            padding: EdgeInsets.zero,
            color: ColorManager.getSurface(context),
            onSelected: (value) {
              if (value == 'edit') {
                onEdit?.call();
              } else if (value == 'delete') {
                onDelete?.call();
              }
            },
            itemBuilder: (ctx) => [
              if (onEdit != null)
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      const Icon(LucideIcons.pencil, size: 16),
                      const SizedBox(width: 8),
                      Text('common.edit'.tr(), style: TextStyles.font13Regular(ctx)),
                    ],
                  ),
                ),
              if (onDelete != null)
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(LucideIcons.trash2, size: 16, color: Colors.red),
                      const SizedBox(width: 8),
                      Text(
                        'common.delete'.tr(),
                        style: TextStyles.font13Regular(ctx).copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
