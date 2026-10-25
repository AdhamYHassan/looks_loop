import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/checkout/domain/entities/payment_method_entity.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_radio_indicator.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CheckoutPaymentCard extends StatelessWidget {
  final PaymentMethodEntity method;
  final bool isSelected;
  final VoidCallback onSelect;

  const CheckoutPaymentCard({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final selectedBg = ColorManager.getSurface(context);
    final unselectedBg = ColorManager.getBackground(context);
    final borderColor = isSelected
        ? ColorManager.getText(context)
        : ColorManager.getBorder(context);

    final isSelectable = method.isSelectable;

    return InkWell(
      onTap: isSelectable ? onSelect : null,
      borderRadius: BorderRadius.circular(4.r),
      child: Opacity(
        opacity: isSelectable ? 1.0 : 0.6,
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
                      method.label.toUpperCase(),
                      style: TextStyles.font14SemiBold(context).copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        fontSize: 13.sp,
                        color: isSelectable
                            ? ColorManager.getText(context)
                            : ColorManager.getTextMuted(context),
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
              if (method.badge != null)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.r),
                    border: Border.all(
                      color: const Color(0xFFD48B6A),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    method.badge!,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: const Color(0xFFD48B6A),
                    ),
                  ),
                )
              else
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.r),
                    border: Border.all(
                      color: ColorManager.getText(context),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    method.value == 'card'
                        ? LucideIcons.creditCard
                        : LucideIcons.banknote,
                    size: 16.sp,
                    color: ColorManager.getText(context),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
