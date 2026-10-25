import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_radio_indicator.dart';

class CheckoutAddressCard extends StatelessWidget {
  final AddressEntity address;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onEdit;

  const CheckoutAddressCard({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onSelect,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.getSurface(context)
              : ColorManager.getBackground(context),
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.getText(context)
                : ColorManager.getBorder(context),
            width: isSelected ? 1.5.w : 1.w,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckoutRadioIndicator(isSelected: isSelected),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: ColorManager.getBorder(context),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                        child: Text(
                          address.displayLabel.toUpperCase(),
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: ColorManager.getText(context),
                          ),
                        ),
                      ),
                      if (address.isDefault) ...[
                        Gap(6.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: ColorManager.olive,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                          child: Text(
                            'DEFAULT',
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Gap(8.h),
                  Text(
                    address.contactName,
                    style: TextStyles.font13TextBold(context).copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(2.h),
                  Text(
                    address.phone,
                    style: TextStyles.font13MutedMedium(context)
                        .copyWith(fontSize: 12.sp),
                  ),
                  Gap(2.h),
                  Text(
                    address.formattedAddress,
                    style: TextStyles.font13MutedMedium(context)
                        .copyWith(fontSize: 12.sp),
                  ),
                  if (address.cityName.isNotEmpty) ...[
                    Gap(2.h),
                    Text(
                      address.cityName,
                      style: TextStyles.font13MutedMedium(context)
                          .copyWith(fontSize: 12.sp),
                    ),
                  ],
                ],
              ),
            ),
            InkWell(
              onTap: onEdit,
              child: Padding(
                padding: EdgeInsets.only(left: 8.w, bottom: 8.h),
                child: Text(
                  'EDIT',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: ColorManager.getText(context),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
