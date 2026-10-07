import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/helpers/app_formatters.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/orders/domain/entities/order_pricing_entity.dart';

class OrderSummarySection extends StatelessWidget {
  final OrderPricingEntity pricing;

  const OrderSummarySection({super.key, required this.pricing});

  @override
  Widget build(BuildContext context) {
    final currency = 'orders.currency'.tr();

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
            'orders.order_summary'.tr(),
            style: TextStyles.font11SemiBold(context).copyWith(
              letterSpacing: 1.2,
              color: ColorManager.getTextMuted(context),
            ),
          ),
          Gap(12.h),
          _buildRow(
            context,
            label: 'orders.subtotal'.tr(),
            value: '${AppFormatters.amount(pricing.subtotal)} $currency',
          ),
          if (pricing.totalDiscount > 0) ...[
            Gap(8.h),
            _buildRow(
              context,
              label: 'orders.discount'.tr(),
              value: '-${AppFormatters.amount(pricing.totalDiscount)} $currency',
              valueColor: ColorManager.orange,
            ),
          ],
          Gap(8.h),
          _buildRow(
            context,
            label: 'orders.delivery'.tr(),
            value: pricing.deliveryFee > 0
                ? '${AppFormatters.amount(pricing.deliveryFee)} $currency'
                : 'orders.free'.tr(),
            valueColor: pricing.deliveryFee == 0
                ? const Color(0xFF2E7D4F)
                : ColorManager.getText(context),
          ),
          Gap(12.h),
          Divider(color: ColorManager.getBorder(context), height: 1),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'orders.total'.tr(),
                style: TextStyles.font14SemiBold(context).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${AppFormatters.amount(pricing.total)} $currency',
                style: TextStyles.font18SemiBold(context).copyWith(
                  fontWeight: FontWeight.w700,
                  color: ColorManager.olive,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context, {
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles.font13Regular(context).copyWith(
            color: ColorManager.getTextMuted(context),
          ),
        ),
        Text(
          value,
          style: TextStyles.font13Medium(context).copyWith(
            color: valueColor ?? ColorManager.getText(context),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
