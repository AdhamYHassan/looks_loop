import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/loaders/look_around_eyes_loader.dart';

class OrdersEmptyView extends StatelessWidget {
  const OrdersEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LookAroundEyesLoader(
              width: 120,
              color: ColorManager.getAccent(context),
            ),
            const SizedBox(height: 24),
            Text(
              'orders.empty_title'.tr(),
              textAlign: TextAlign.center,
              style: TextStyles.font18SemiBold(context),
            ),
            const SizedBox(height: 8),
            Text(
              'orders.empty_subtitle'.tr(),
              textAlign: TextAlign.center,
              style: TextStyles.font13Regular(context)
                  .copyWith(color: ColorManager.getTextMuted(context)),
            ),
          ],
        ),
      ),
    );
  }
}
