import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/helpers/password_validator.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/auth/presentation/widgets/password_requirements_view.dart';
import 'package:looks_loop/features/auth/presentation/widgets/register_labeled_field.dart';

/// Atomic section managing password input, live policy view, and confirmation.
class RegisterPasswordSection extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final PasswordValidationResult validationResult;

  const RegisterPasswordSection({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.validationResult,
  });

  @override
  State<RegisterPasswordSection> createState() =>
      _RegisterPasswordSectionState();
}

class _RegisterPasswordSectionState extends State<RegisterPasswordSection> {
  bool _isPasswordObscure = true;
  bool _isConfirmObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        RegisterLabeledField(
          controller: widget.passwordController,
          label: 'auth.password'.tr(),
          hintText: '••••••••',
          keyboardType: TextInputType.visiblePassword,
          isObscure: _isPasswordObscure,
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordObscure ? Icons.visibility_off : Icons.visibility,
              color: ColorManager.olive,
              size: 20.sp,
            ),
            onPressed: () =>
                setState(() => _isPasswordObscure = !_isPasswordObscure),
          ),
        ),
        SizedBox(height: 10.h),
        PasswordRequirementsView(result: widget.validationResult),
        SizedBox(height: 14.h),
        RegisterLabeledField(
          controller: widget.confirmPasswordController,
          label: 'auth.confirm_password'.tr(),
          hintText: 'auth.confirm_password_hint'.tr(),
          keyboardType: TextInputType.visiblePassword,
          isObscure: _isConfirmObscure,
          suffixIcon: IconButton(
            icon: Icon(
              _isConfirmObscure ? Icons.visibility_off : Icons.visibility,
              color: ColorManager.olive,
              size: 20.sp,
            ),
            onPressed: () =>
                setState(() => _isConfirmObscure = !_isConfirmObscure),
          ),
        ),
      ],
    );
  }
}
