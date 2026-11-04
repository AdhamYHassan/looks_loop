import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

class AccountFieldCard extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool isObscure;
  final bool readOnly;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;

  const AccountFieldCard({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.isObscure = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = ColorManager.isDark(context);
    final fieldBg = isDark ? const Color(0xFF14170F) : const Color(0xFFEDE9DD);
    final textColor = ColorManager.getText(context);
    final hintColor = ColorManager.getTextMuted(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: ColorManager.getText(context),
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            color: textColor,
            fontSize: 13.5.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Cairo',
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintColor.withValues(alpha: 0.7),
              fontSize: 13.sp,
              fontFamily: 'Cairo',
            ),
            filled: true,
            fillColor: fieldBg,
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 12.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: ColorManager.getBorder(context).withValues(alpha: 0.4),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: ColorManager.getBorder(context).withValues(alpha: 0.4),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: ColorManager.olive,
                width: 1.2.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

