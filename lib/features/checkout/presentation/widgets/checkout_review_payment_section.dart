import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/checkout/domain/entities/payment_method_entity.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_section_header.dart';

class CheckoutReviewPaymentSection extends StatelessWidget {
  final PaymentMethodEntity? paymentMethod;
  final VoidCallback onEdit;

  const CheckoutReviewPaymentSection({
    super.key,
    required this.paymentMethod,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckoutSectionHeader(
          title: 'PAYMENT',
          onEdit: onEdit,
        ),
        Text(
          paymentMethod?.label.toUpperCase() ?? 'NO PAYMENT METHOD SELECTED',
          style: TextStyles.font14SemiBold(context).copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (paymentMethod != null && paymentMethod!.description.isNotEmpty) ...[
          Gap(2.h),
          Text(
            paymentMethod!.description,
            style: TextStyles.font13MutedMedium(context).copyWith(
              fontSize: 12.sp,
            ),
          ),
        ],
      ],
    );
  }
}
