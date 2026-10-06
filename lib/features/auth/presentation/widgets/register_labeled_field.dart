import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

/// Styled input field with top label, optional badge, and smooth focus styling.
class RegisterLabeledField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool isOptional;
  final bool isObscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;

  const RegisterLabeledField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.isOptional = false,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = ColorManager.isDark(context);
    final fieldBg = isDark
        ? const Color(0xFF14170F)
        : const Color(0xFFEDE9DD);
    final textColor = ColorManager.getText(context);
    final hintColor = ColorManager.getTextMuted(context);

    final borderShape = BorderRadius.circular(10.r);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: ColorManager.backgroundDark,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            if (isOptional) ...[
              SizedBox(width: 4.w),
              Text(
                '(OPTIONAL)',
                style: TextStyle(
                  color: hintColor.withValues(alpha: 0.7),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          validator: validator,
          style: TextStyle(
            color: textColor,
            fontSize: 14.5.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Cairo',
          ),
          cursorColor: ColorManager.olive,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintColor,
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Cairo',
            ),
            filled: true,
            fillColor: fieldBg,
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 13.h,
            ),
            border: OutlineInputBorder(
              borderRadius: borderShape,
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderShape,
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1.2.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderShape,
              borderSide: BorderSide(
                color: ColorManager.olive,
                width: 1.5.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
