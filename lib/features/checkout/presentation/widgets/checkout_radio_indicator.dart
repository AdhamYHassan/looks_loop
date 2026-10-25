import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

class CheckoutRadioIndicator extends StatelessWidget {
  final bool isSelected;

  const CheckoutRadioIndicator({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18.w,
      height: 18.w,
      margin: EdgeInsets.only(top: 2.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? ColorManager.getText(context)
              : ColorManager.getBorder(context),
          width: 1.5.w,
        ),
      ),
      child: isSelected
          ? Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.getText(context),
              ),
            )
          : null,
    );
  }
}
