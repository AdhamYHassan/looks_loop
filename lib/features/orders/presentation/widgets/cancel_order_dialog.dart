import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

Future<bool?> showCancelOrderDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (dialogCtx) => AlertDialog(
      backgroundColor: ColorManager.getCard(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Text(
        'orders.cancel_confirm_title'.tr(),
        style: TextStyles.font18SemiBold(context),
      ),
      content: Text(
        'orders.cancel_confirm_message'.tr(),
        style: TextStyles.font14Regular(context),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogCtx).pop(false),
          child: Text(
            'common.cancel'.tr(),
            style: TextStyles.font14Regular(context),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogCtx).pop(true),
          child: Text(
            'orders.cancel_order'.tr(),
            style: TextStyles.font14SemiBold(context).copyWith(
              color: ColorManager.orange,
            ),
          ),
        ),
      ],
    ),
  );
}
