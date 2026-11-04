import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

class AccountGenderSelector extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String> onGenderChanged;

  const AccountGenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = ColorManager.isDark(context);
    final isFemale = selectedGender.toLowerCase() == 'female';
    final isMale = selectedGender.toLowerCase() == 'male';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'account.gender'.tr(),
          style: TextStyle(
            color: ColorManager.getText(context),
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Expanded(
              child: _buildGenderOption(
                context: context,
                label: 'account.female'.tr(),
                isSelected: isFemale,
                isDark: isDark,
                onTap: () => onGenderChanged('female'),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _buildGenderOption(
                context: context,
                label: 'account.male'.tr(),
                isSelected: isMale,
                isDark: isDark,
                onTap: () => onGenderChanged('male'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final activeBg = ColorManager.olive;
    final inactiveBg =
        isDark ? const Color(0xFF14170F) : const Color(0xFFEDE9DD);
    final activeText = Colors.white;
    final inactiveText = ColorManager.getText(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? activeBg : inactiveBg,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.olive
                : ColorManager.getBorder(context).withValues(alpha: 0.4),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? activeText : inactiveText,
            fontSize: 13.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }
}
