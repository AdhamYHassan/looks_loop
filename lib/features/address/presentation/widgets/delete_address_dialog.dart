import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

Future<bool?> showDeleteAddressDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: ColorManager.getSurface(ctx),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      title: Text(
        'address.delete_title'.tr(),
        style: TextStyles.font18SemiBold(ctx).copyWith(color: Colors.red),
      ),
      content: Text(
        'address.delete_confirm_msg'.tr(),
        style: TextStyles.font13Regular(ctx).copyWith(height: 1.4),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(
            'common.close'.tr(),
            style: TextStyles.font13MutedMedium(ctx),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          onPressed: () => Navigator.of(ctx).pop(true),
          child: Text('common.delete'.tr()),
        ),
      ],
    ),
  );
}

