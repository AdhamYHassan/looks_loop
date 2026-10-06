import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

/// Segmented selector for Gender (FEMALE / MALE) with animated toggle states.
class RegisterGenderSelector extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String> onGenderSelected;
  final bool isOptional;

  const RegisterGenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
    this.isOptional = false,
  });

  @override
  Widget build(BuildContext context) {
    final hintColor = ColorManager.getTextMuted(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              'auth.gender'.tr(),
              style: TextStyle(
                color: ColorManager.backgroundDark,
                fontSize: 11.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1,
                fontFamily: 'Cairo',
              ),
            ),
            if (isOptional) ...[
              SizedBox(width: 6.w),
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
        Row(
          children: [
            Expanded(
              child: _GenderOptionButton(
                label: 'auth.female'.tr(),
                isSelected: selectedGender == 'female',
                onTap: () => onGenderSelected('female'),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _GenderOptionButton(
                label: 'auth.male'.tr(),
                isSelected: selectedGender == 'male',
                onTap: () => onGenderSelected('male'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GenderOptionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderOptionButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = ColorManager.isDark(context);
    final unselectedBg = isDark
        ? const Color(0xFF14170F)
        : const Color(0xFFEDE9DD);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      height: 46.h,
      decoration: BoxDecoration(
        color: isSelected ? ColorManager.olive : unselectedBg,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isSelected ? ColorManager.olive : Colors.transparent,
          width: 1.2.w,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10.r),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFFFBF8F2)
                    : ColorManager.getText(context),
                fontSize: 13.5.sp,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                letterSpacing: 0.5,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
