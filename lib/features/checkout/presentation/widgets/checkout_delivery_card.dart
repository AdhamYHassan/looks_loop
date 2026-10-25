import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/checkout/domain/entities/delivery_method_entity.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_radio_indicator.dart';

class CheckoutDeliveryCard extends StatelessWidget {
  final DeliveryMethodEntity method;
  final bool isSelected;
  final VoidCallback onSelect;

  const CheckoutDeliveryCard({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final selectedBg = ColorManager.getSurface(context);
    final unselectedBg = ColorManager.getBackground(context);
    final borderColor =
        isSelected ? ColorManager.getText(context) : ColorManager.getBorder(context);

    return InkWell(
      onTap: onSelect,
      borderRadius: BorderRadius.circular(4.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : unselectedBg,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            CheckoutRadioIndicator(isSelected: isSelected),
            Gap(14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.name.toUpperCase(),
                    style: TextStyles.font14SemiBold(context).copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      fontSize: 13.sp,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    method.description,
                    style: TextStyles.font13MutedMedium(context).copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              method.priceDisplay,
              style: TextStyles.font14SemiBold(context).copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 13.sp,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
