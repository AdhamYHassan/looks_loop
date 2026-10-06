import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/loaders/look_around_eyes_loader.dart';

class AddressEmptyView extends StatelessWidget {
  final VoidCallback onAddAddress;

  const AddressEmptyView({
    super.key,
    required this.onAddAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LookAroundEyesLoader(
              width: 120,
              color: ColorManager.getAccent(context),
            ),
            const SizedBox(height: 24),
            Text(
              'address.empty_title'.tr(),
              style: TextStyles.font18SemiBold(context).copyWith(
                color: ColorManager.getText(context),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'address.empty_subtitle'.tr(),
              style: TextStyles.font13Regular(context).copyWith(
                color: ColorManager.getTextMuted(context),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: onAddAddress,
                icon: const Icon(Icons.add_rounded, size: 20),
                label: Text(
                  'address.add_address_button'.tr(),
                  style: TextStyles.font14SemiBold(context).copyWith(
                    color: ColorManager.cream,
                    letterSpacing: 0.8,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.olive,
                  foregroundColor: ColorManager.cream,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
