import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

/// Styled input field with asymmetric rounded corners and olive focus states.
class LoginInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelKey;
  final bool isObscure;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const LoginInputField({
    super.key,
    required this.controller,
    required this.labelKey,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = ColorManager.isDark(context);
    final fieldBg = isDark
        ? const Color(0xFF14170F)
        : const Color(0xFFEDE9DD);
    final textColor = ColorManager.getText(context);
    final hintColor = ColorManager.getTextMuted(context);

    final asymmetricBorder = BorderRadius.only(
      topLeft: Radius.circular(18.r),
      topRight: Radius.circular(18.r),
      bottomRight: Radius.circular(18.r),
      bottomLeft: Radius.circular(6.r),
    );

    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      style: TextStyle(
        color: textColor,
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Cairo',
      ),
      cursorColor: ColorManager.olive,
      decoration: InputDecoration(
        labelText: labelKey.tr(),
        labelStyle: TextStyle(
          color: hintColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Cairo',
        ),
        floatingLabelStyle: TextStyle(
          color: ColorManager.olive,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          fontFamily: 'Cairo',
        ),
        filled: true,
        fillColor: fieldBg,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 18.w,
          vertical: 16.h,
        ),
        border: OutlineInputBorder(
          borderRadius: asymmetricBorder,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: asymmetricBorder,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1.5.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: asymmetricBorder,
          borderSide: BorderSide(
            color: ColorManager.olive,
            width: 1.5.w,
          ),
        ),
      ),
    );
  }
}
