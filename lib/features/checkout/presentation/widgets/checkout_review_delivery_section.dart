import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/checkout/domain/entities/delivery_method_entity.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_section_header.dart';

class CheckoutReviewDeliverySection extends StatelessWidget {
  final DeliveryMethodEntity? deliveryMethod;
  final double subtotal;
  final VoidCallback onEdit;

  const CheckoutReviewDeliverySection({
    super.key,
    required this.deliveryMethod,
    required this.subtotal,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final method = deliveryMethod;
    final cost = method?.calculateCost(subtotal);
    final costText = cost == null
        ? ''
        : cost == 0.0
            ? 'FREE'
            : '${cost.toStringAsFixed(0)} EGP';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckoutSectionHeader(
          title: 'DELIVERY',
          onEdit: onEdit,
        ),
        Text(
          method?.name.toUpperCase() ?? 'NO DELIVERY METHOD SELECTED',
          style: TextStyles.font14SemiBold(context).copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (method != null) ...[
          Gap(2.h),
          Text(
            method.description.isNotEmpty
                ? '${method.description} · $costText'
                : costText,
            style: TextStyles.font13MutedMedium(context).copyWith(
              fontSize: 12.sp,
            ),
          ),
        ],
      ],
    );
  }
}
