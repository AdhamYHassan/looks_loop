import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

/// Luxury bottom sheet date picker tailored to the LookLoops design system.
/// Uses CupertinoDatePicker wheel physics with themed Olive/Cream action buttons.
class LookLoopsDatePickerSheet extends StatefulWidget {
  final DateTime initialDate;
  final DateTime minimumDate;
  final DateTime maximumDate;
  final ValueChanged<DateTime> onDateSelected;

  const LookLoopsDatePickerSheet({
    super.key,
    required this.initialDate,
    required this.minimumDate,
    required this.maximumDate,
    required this.onDateSelected,
  });

  /// Platform-adaptive date picker:
  /// - iOS: LookLoops Cupertino wheel bottom sheet.
  /// - Android: LookLoops branded Material date picker dialog.
  static Future<DateTime?> show({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
  }) async {
    final isIos = Theme.of(context).platform == TargetPlatform.iOS;
    final isDark = ColorManager.isDark(context);
    final minDate = minimumDate ?? DateTime(1920);
    final maxDate = maximumDate ?? DateTime.now();

    if (isIos) {
      return showModalBottomSheet<DateTime>(
        context: context,
        isScrollControlled: true,
        backgroundColor: isDark
            ? ColorManager.surfaceDark
            : ColorManager.surfaceLight,
        barrierColor: ColorManager.ink.withValues(alpha: 0.65),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        builder: (ctx) => LookLoopsDatePickerSheet(
          initialDate: initialDate,
          minimumDate: minDate,
          maximumDate: maxDate,
          onDateSelected: (_) {},
        ),
      );
    }

    // Android / Other: Custom-themed LookLoops Material Date Picker
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: minDate,
      lastDate: maxDate,
      builder: (ctx, child) {
        return Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: isDark
                ? const ColorScheme.dark(
                    primary: ColorManager.olive,
                    onPrimary: ColorManager.cream,
                    surface: ColorManager.surfaceDark,
                    onSurface: ColorManager.cream,
                  )
                : const ColorScheme.light(
                    primary: ColorManager.olive,
                    onPrimary: ColorManager.cream,
                    surface: ColorManager.surfaceLight,
                    onSurface: ColorManager.ink,
                  ),
            dialogTheme: DialogThemeData(
              backgroundColor: isDark
                  ? ColorManager.surfaceDark
                  : ColorManager.surfaceLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorManager.olive,
                textStyle: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }

  @override
  State<LookLoopsDatePickerSheet> createState() =>
      _LookLoopsDatePickerSheetState();
}

class _LookLoopsDatePickerSheetState extends State<LookLoopsDatePickerSheet> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ColorManager.isDark(context);
    final textMuted = ColorManager.getTextMuted(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: textMuted.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 12.h),

            // Top action bar
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(null),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 6.h,
                      ),
                      child: Text(
                        'common.cancel'.tr(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                          color: textMuted,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      'auth.date_of_birth'.tr(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: ColorManager.getText(context),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: GestureDetector(
                      onTap: () {
                        widget.onDateSelected(_selectedDate);
                        Navigator.of(context).pop(_selectedDate);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 6.h,
                        ),
                        child: Text(
                          'common.done'.tr(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w800,
                            color: ColorManager.olive,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: ColorManager.getBorder(context),
              height: 18.h,
              thickness: 1.w,
            ),

            // Wheel Date Picker
            SizedBox(
              height: 200.h,
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  brightness: isDark ? Brightness.dark : Brightness.light,
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      color: ColorManager.getText(context),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: widget.initialDate,
                  minimumDate: widget.minimumDate,
                  maximumDate: widget.maximumDate,
                  onDateTimeChanged: (newDate) {
                    _selectedDate = newDate;
                    widget.onDateSelected(newDate);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
