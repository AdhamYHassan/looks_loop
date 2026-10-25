import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_summary_entity.dart';
import 'package:looks_loop/features/checkout/domain/entities/delivery_method_entity.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_section_header.dart';

class CheckoutReviewPriceSummary extends StatelessWidget {
  final CartSummaryEntity summary;
  final DeliveryMethodEntity? deliveryMethod;

  const CheckoutReviewPriceSummary({
    super.key,
    required this.summary,
    required this.deliveryMethod,
  });

  @override
  Widget build(BuildContext context) {
    final deliveryCost =
        deliveryMethod?.calculateCost(summary.subtotal) ?? 0.0;
    final finalTotal = summary.subtotal - summary.discount + deliveryCost;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckoutSectionHeader(title: 'PRICE SUMMARY'),
        _buildRow(
          context,
          'Subtotal',
          '${summary.subtotal.toStringAsFixed(0)} EGP',
        ),
        if (summary.discount > 0)
          _buildRow(
            context,
            'Discount',
            '-${summary.discount.toStringAsFixed(0)} EGP',
            isDiscount: true,
          ),
        _buildRow(
          context,
          'Delivery',
          deliveryCost == 0
              ? 'FREE'
              : '${deliveryCost.toStringAsFixed(0)} EGP',
        ),
        Gap(8.h),
        const Divider(height: 1, color: ColorManager.line),
        Gap(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'TOTAL',
              style: TextStyles.font14SemiBold(context).copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
            Text(
              '${finalTotal.toStringAsFixed(0)} EGP',
              style: TextStyles.font14SemiBold(context).copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context, String label, String value,
      {bool isDiscount = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyles.font13MutedMedium(context).copyWith(
              fontSize: 12.sp,
            ),
          ),
          Text(
            value,
            style: TextStyles.font14Medium(context).copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: isDiscount ? Colors.green.shade700 : null,
            ),
          ),
        ],
      ),
    );
  }
}
