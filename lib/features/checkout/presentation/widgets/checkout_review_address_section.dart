import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_section_header.dart';

class CheckoutReviewAddressSection extends StatelessWidget {
  final AddressEntity? address;
  final VoidCallback onEdit;

  const CheckoutReviewAddressSection({
    super.key,
    required this.address,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckoutSectionHeader(
          title: 'DELIVERY ADDRESS',
          onEdit: onEdit,
        ),
        if (address != null) ...[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            margin: EdgeInsets.only(bottom: 6.h),
            decoration: BoxDecoration(
              color: ColorManager.getBorder(context),
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: Text(
              address!.displayLabel.toUpperCase(),
              style: TextStyle(
                fontSize: 9.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: ColorManager.getText(context),
              ),
            ),
          ),
          Text(
            address!.fullName,
            style: TextStyles.font14SemiBold(context).copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(2.h),
          Text(
            address!.phone,
            style: TextStyles.font13MutedMedium(context).copyWith(
              fontSize: 12.sp,
            ),
          ),
          Gap(2.h),
          Text(
            address!.singleLine,
            style: TextStyles.font13MutedMedium(context).copyWith(
              fontSize: 12.sp,
            ),
          ),
        ] else
          Text(
            'No address selected',
            style: TextStyles.font13MutedMedium(context),
          ),
      ],
    );
  }
}
