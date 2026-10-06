import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/helpers/password_validator.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/auth/presentation/widgets/password_requirement_item.dart';

/// Editorial list container presenting live password strength and policy criteria.
class PasswordRequirementsView extends StatelessWidget {
  final PasswordValidationResult result;

  const PasswordRequirementsView({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = ColorManager.isDark(context);
    final bg = isDark
        ? const Color(0xFF161A11)
        : const Color(0xFFF3EFE6);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: result.isValid
              ? ColorManager.olive.withValues(alpha: 0.5)
              : ColorManager.getBorder(context).withValues(alpha: 0.4),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PasswordRequirementItem(
            label: 'auth.pwd_req_not_similar'.tr(),
            isMet: result.notSimilarToPersonalInfo,
          ),
          PasswordRequirementItem(
            label: 'auth.pwd_req_min_8'.tr(),
            isMet: result.hasMinLength,
          ),
          PasswordRequirementItem(
            label: 'auth.pwd_req_not_common'.tr(),
            isMet: result.notCommon,
          ),
          PasswordRequirementItem(
            label: 'auth.pwd_req_not_numeric'.tr(),
            isMet: result.notEntirelyNumeric,
          ),
        ],
      ),
    );
  }
}
