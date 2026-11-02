import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/helpers/responsive_helper.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/core/widgets/app_snack_bar.dart';
import 'package:looks_loop/features/more/presentation/bloc/more_cubit.dart';
import 'package:looks_loop/features/more/presentation/widgets/delete_account_dialog.dart';
import 'package:looks_loop/features/more/presentation/widgets/more_item_tile.dart';
import 'package:looks_loop/features/more/presentation/widgets/more_section_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingsContent extends StatelessWidget {
  final bool isGuest;

  const SettingsContent({super.key, required this.isGuest});

  void _clearCache(BuildContext context) {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    AppSnackBar.showSuccess(
      context,
      message: 'settings.items.cache_cleared'.tr(),
    );
  }

  Future<void> _handleDeleteAccount(BuildContext context) async {
    final password = await showDeleteAccountDialog(context);
    if (password != null && password.isNotEmpty && context.mounted) {
      final result = await context.read<MoreCubit>().deleteAccount(password);
      if (context.mounted) {
        switch (result) {
          case ApiSuccess():
            AppSnackBar.showSuccess(
              context,
              message: 'settings.items.delete_requested'.tr(),
            );
            Navigator.of(context).pop();
          case ApiFailure(:final failure):
            AppSnackBar.showError(
              context,
              message: failure.message,
            );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveHelper.getContentPadding(context);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MoreSectionCard(
            title: 'settings.sections.data_storage'.tr(),
            items: [
              MoreItemTile(
                icon: LucideIcons.trash2,
                label: 'settings.items.clear_cache'.tr(),
                subtitle: 'settings.items.clear_cache_sub'.tr(),
                onTap: () => _clearCache(context),
              ),
            ],
          ),
          Gap(20.h),
          MoreSectionCard(
            title: 'settings.sections.about_app'.tr(),
            items: [
              MoreItemTile(
                icon: LucideIcons.info,
                label: 'settings.items.app_version'.tr(),
                subtitle: '1.0.0 (Build 1)',
              ),
            ],
          ),
          if (!isGuest) ...[
            Gap(20.h),
            MoreSectionCard(
              title: 'settings.sections.account_actions'.tr(),
              items: [
                MoreItemTile(
                  icon: LucideIcons.userX,
                  label: 'settings.items.delete_account'.tr(),
                  subtitle: 'settings.items.delete_account_sub'.tr(),
                  onTap: () => _handleDeleteAccount(context),
                ),
              ],
            ),
          ],
          Gap(32.h),
        ],
      ),
    );
  }
}
