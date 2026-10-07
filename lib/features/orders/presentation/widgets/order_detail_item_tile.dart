import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/helpers/app_formatters.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/orders/domain/entities/order_item_entity.dart';

class OrderDetailItemTile extends StatelessWidget {
  final OrderItemEntity item;

  const OrderDetailItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final currency = 'orders.currency'.tr();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: AppCachedImage(
              imageUrl: item.image,
              width: 64.w,
              height: 64.h,
              fit: BoxFit.cover,
            ),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.brandName.isNotEmpty) ...[
                  Text(
                    item.brandName.toUpperCase(),
                    style: TextStyles.font11SemiBold(context).copyWith(
                      letterSpacing: 1.1,
                      color: ColorManager.getTextMuted(context),
                    ),
                  ),
                  Gap(2.h),
                ],
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font14Medium(context),
                ),
                Gap(4.h),
                Text(
                  '${item.variant} · ${'orders.qty'.tr()}: ${item.quantity}',
                  style: TextStyles.font12Regular(context).copyWith(
                    color: ColorManager.getTextMuted(context),
                  ),
                ),
              ],
            ),
          ),
          Gap(8.w),
          Text(
            '${AppFormatters.amount(item.lineTotal)} $currency',
            style: TextStyles.font14SemiBold(context),
          ),
        ],
      ),
    );
  }
}
