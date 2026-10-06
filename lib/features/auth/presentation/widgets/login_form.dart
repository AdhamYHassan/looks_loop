import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_create_account_prompt.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_input_field.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_submit_button.dart';
import 'package:looks_loop/features/auth/presentation/widgets/staggered_reveal.dart';

/// Staggered login form holding phone, password, forgot password,
/// and primary submit CTA with animated transitions.
class LoginForm extends StatefulWidget {
  final void Function(String phone, String password)? onSubmit;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onCreateAccount;
  final bool isLoading;

  const LoginForm({
    super.key,
    this.onSubmit,
    this.onForgotPassword,
    this.onCreateAccount,
    this.isLoading = false,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AnimationController _entrance;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
  }

  @override
  void dispose() {
    _entrance.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleObscure() => setState(() => _isObscure = !_isObscure);

  void _submit() => widget.onSubmit?.call(
        _phoneController.text.trim(),
        _passwordController.text,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        StaggeredReveal(
          animation: _entrance,
          index: 0,
          child: LoginInputField(
            controller: _phoneController,
            labelKey: 'auth.phone_number',
            keyboardType: TextInputType.phone,
          ),
        ),
        SizedBox(height: 12.h),
        StaggeredReveal(
          animation: _entrance,
          index: 1,
          child: LoginInputField(
            controller: _passwordController,
            labelKey: 'auth.password',
            isObscure: _isObscure,
            suffixIcon: IconButton(
              onPressed: _toggleObscure,
              icon: Icon(
                _isObscure ? Icons.visibility_off : Icons.visibility,
                color: ColorManager.olive,
                size: 20.sp,
              ),
            ),
          ),
        ),
        StaggeredReveal(
          animation: _entrance,
          index: 2,
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: widget.onForgotPassword,
              child: Text(
                'auth.forgot_password'.tr(),
                style: TextStyle(
                  color: ColorManager.getAccent(context),
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        StaggeredReveal(
          animation: _entrance,
          index: 3,
          child: LoginSubmitButton(
            label: 'auth.sign_in'.tr(),
            isLoading: widget.isLoading,
            onPressed: _submit,
          ),
        ),
        SizedBox(height: 20.h),
        StaggeredReveal(
          animation: _entrance,
          index: 4,
          child: LoginCreateAccountPrompt(
            onTap: widget.onCreateAccount,
          ),
        ),
      ],
    );
  }
}
