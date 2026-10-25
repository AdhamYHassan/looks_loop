import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class CheckoutStickyCta extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final String? priceText;

  const CheckoutStickyCta({
    super.key,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
    this.priceText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: ColorManager.getBackground(context),
        border: Border(
          top: BorderSide(
            color: ColorManager.getBorder(context),
            width: 1.w,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 48.h,
          child: priceText != null
              ? Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'TOTAL',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: ColorManager.getTextMuted(context),
                          ),
                        ),
                        Text(
                          priceText!,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.2,
                            color: ColorManager.getText(context),
                          ),
                        ),
                      ],
                    ),
                    Gap(20.w),
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: _buildButton(context),
                      ),
                    ),
                  ],
                )
              : _buildButton(context),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.olive,
        foregroundColor: Colors.white,
        disabledBackgroundColor: ColorManager.olive.withValues(alpha: 0.4),
        disabledForegroundColor: Colors.white70,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      child: Text(
        label,
        style: TextStyles.font11WhiteEyebrow.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
