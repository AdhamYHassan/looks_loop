import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/helpers/app_formatters.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/orders/domain/entities/order_detail_entity.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_status_badge.dart';

class OrderDetailHeader extends StatelessWidget {
  final OrderDetailEntity order;

  const OrderDetailHeader({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final langCode = context.locale.languageCode;
    final dateStr = order.created != null
        ? AppFormatters.shortDate(order.created!, langCode)
        : '';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.getCard(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.getBorder(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '#${order.orderNumber}',
            style: TextStyles.font18SemiBold(context).copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (dateStr.isNotEmpty) ...[
            Gap(4.h),
            Text(
              'orders.placed_on'.tr(args: [dateStr]),
              style: TextStyles.font12Regular(context).copyWith(
                color: ColorManager.getTextMuted(context),
              ),
            ),
          ],
          Gap(12.h),
          OrderStatusBadge(
            status: order.status,
            fallbackLabel: order.statusDisplay,
          ),
        ],
      ),
    );
  }
}
