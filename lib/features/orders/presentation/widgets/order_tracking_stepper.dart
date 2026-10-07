import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/helpers/app_formatters.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/orders/domain/entities/order_detail_entity.dart';
import 'package:looks_loop/features/orders/domain/entities/order_status.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class OrderTrackingStepper extends StatelessWidget {
  final OrderDetailEntity order;

  const OrderTrackingStepper({super.key, required this.order});

  static const _steps = [
    (OrderStatus.pending, 'orders.tracking.placed'),
    (OrderStatus.confirmed, 'orders.tracking.confirmed'),
    (OrderStatus.processing, 'orders.tracking.processing'),
    (OrderStatus.shipped, 'orders.tracking.shipped'),
    (OrderStatus.delivered, 'orders.tracking.delivered'),
  ];

  int get _currentStepIndex {
    return switch (order.status) {
      OrderStatus.pending => 0,
      OrderStatus.confirmed => 1,
      OrderStatus.processing => 2,
      OrderStatus.shipped => 3,
      OrderStatus.delivered => 4,
      OrderStatus.cancelled || OrderStatus.unknown => -1,
    };
  }

  @override
  Widget build(BuildContext context) {
    final currentIdx = _currentStepIndex;
    final historyMap = {
      for (final h in order.statusHistory) h.status: h.at,
    };
    final langCode = context.locale.languageCode;

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
            'orders.order_tracking'.tr(),
            style: TextStyles.font11SemiBold(context).copyWith(
              letterSpacing: 1.2,
              color: ColorManager.getTextMuted(context),
            ),
          ),
          Gap(16.h),
          for (int i = 0; i < _steps.length; i++) ...[
            _buildStepRow(
              context,
              index: i,
              isDone: currentIdx >= i,
              isCurrent: currentIdx == i,
              isLast: i == _steps.length - 1,
              label: _steps[i].$2.tr(),
              timestamp: historyMap[_steps[i].$1],
              langCode: langCode,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStepRow(
    BuildContext context, {
    required int index,
    required bool isDone,
    required bool isCurrent,
    required bool isLast,
    required String label,
    DateTime? timestamp,
    required String langCode,
  }) {
    final activeColor = ColorManager.olive;
    final mutedColor = ColorManager.getTextMuted(context);
    final dateText = timestamp != null
        ? AppFormatters.shortDate(timestamp, langCode)
        : '';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 22.w,
              height: 22.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone ? activeColor : Colors.transparent,
                border: Border.all(
                  color: isDone
                      ? activeColor
                      : (isCurrent ? activeColor : mutedColor.withValues(alpha: 0.4)),
                  width: isCurrent ? 2.5 : 1.5,
                ),
              ),
              child: isDone
                  ? Icon(LucideIcons.check, size: 12.sp, color: ColorManager.cream)
                  : (isCurrent
                      ? Center(
                          child: Container(
                            width: 6.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: activeColor,
                            ),
                          ),
                        )
                      : null),
            ),
            if (!isLast)
              Container(
                width: 2.w,
                height: 28.h,
                color: isDone
                    ? activeColor
                    : mutedColor.withValues(alpha: 0.25),
              ),
          ],
        ),
        Gap(12.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyles.font13Medium(context).copyWith(
                    fontWeight: isDone || isCurrent
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: isDone || isCurrent
                        ? ColorManager.getText(context)
                        : mutedColor,
                  ),
                ),
                if (dateText.isNotEmpty)
                  Text(
                    dateText,
                    style: TextStyles.font11SemiBold(context).copyWith(
                      color: mutedColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
