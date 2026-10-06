import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

/// Prompt linking new users to the registration flow.
class LoginCreateAccountPrompt extends StatelessWidget {
  final VoidCallback? onTap;

  const LoginCreateAccountPrompt({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final prefix = 'auth.new_to_looks_loop'.tr();
    final action = 'auth.create_account'.tr();
    final accent = ColorManager.getAccent(context);

    return Center(
      child: Text.rich(
        TextSpan(
          text: '$prefix ',
          style: TextStyle(
            color: ColorManager.getTextMuted(context),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Cairo',
          ),
          children: [
            TextSpan(
              text: action,
              style: TextStyle(
                color: accent,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                decorationColor: accent,
                fontFamily: 'Cairo',
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
