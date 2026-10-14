import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/helpers/app_formatters.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_summary_entity.dart';

class CartSummarySection extends StatelessWidget {
  final CartSummaryEntity summary;

  const CartSummarySection({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      color: ColorManager.getSurface(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ORDER SUMMARY',
            style: TextStyles.font11Eyebrow(context).copyWith(
              letterSpacing: 1.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          Gap(14.h),
          _buildRow(
            context,
            label: 'Subtotal',
            value: '${AppFormatters.amount(summary.subtotal)} EGP',
          ),
          Gap(10.h),
          if (summary.discount > 0) ...[
            _buildRow(
              context,
              label: 'Discount',
              value: '-${AppFormatters.amount(summary.discount)} EGP',
              valueColor: ColorManager.orange,
            ),
            Gap(10.h),
          ],
          _buildRow(
            context,
            label: 'Delivery',
            value: summary.deliveryText,
            isMuted: true,
          ),
          Gap(14.h),
          Container(
            height: 1.h,
            color: ColorManager.getBorder(context),
          ),
          Gap(14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TOTAL',
                style: TextStyles.font14Medium(context).copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                '${AppFormatters.amount(summary.total)} EGP',
                style: TextStyles.font16WhiteBold.copyWith(
                  color: ColorManager.getText(context),
                  fontWeight: FontWeight.w800,
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
    bool isMuted = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles.font13Medium(context).copyWith(
            color: isMuted ? ColorManager.getTextMuted(context) : ColorManager.getText(context),
          ),
        ),
        Text(
          value,
          style: TextStyles.font13Medium(context).copyWith(
            color: valueColor ??
                (isMuted ? ColorManager.getTextMuted(context) : ColorManager.getText(context)),
            fontWeight: isMuted ? FontWeight.w400 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
