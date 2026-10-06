import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';
import 'package:looks_loop/features/more/presentation/widgets/more_guest_card.dart';
import 'package:looks_loop/features/more/presentation/widgets/more_header.dart';
import 'package:looks_loop/features/more/presentation/widgets/more_item_tile.dart';
import 'package:looks_loop/features/more/presentation/widgets/more_section_card.dart';
import 'package:looks_loop/features/more/presentation/widgets/more_user_card.dart';
import 'package:looks_loop/features/more/presentation/widgets/sign_out_button.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MoreContent extends StatelessWidget {
  final UserProfileEntity profile;
  final VoidCallback? onSignInTap;
  final VoidCallback? onSignOutTap;
  final VoidCallback? onLanguageTap;
  final Future<void> Function()? onRefresh;

  const MoreContent({
    super.key,
    required this.profile,
    this.onSignInTap,
    this.onSignOutTap,
    this.onLanguageTap,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final localeCode =
        Localizations.maybeLocaleOf(context)?.languageCode ?? 'en';
    final currentLanguage = localeCode == 'ar' ? 'العربية' : 'English';

    return RefreshIndicator(
      color: ColorManager.olive,
      onRefresh: onRefresh ?? () async {},
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MoreHeader(
              greeting:
                  profile.isGuest ? 'more.guest'.tr() : profile.name,
            ),
            if (profile.isGuest)
              MoreGuestCard(onSignInTap: onSignInTap)
            else
              MoreUserCard(
                name: profile.name,
                phone: profile.phone,
                onViewAccountTap: () {},
              ),
            Gap(20.h),
            MoreSectionCard(
              title: 'more.sections.shopping'.tr(),
              items: [
                MoreItemTile(
                  icon: LucideIcons.mapPin,
                  label: 'more.items.addresses'.tr(),
                  subtitle: 'more.items.addresses_sub'.tr(),
                  onTap: () {},
                ),
                MoreItemTile(
                  icon: LucideIcons.package,
                  label: 'more.items.orders'.tr(),
                  subtitle: 'more.items.orders_sub'.tr(),
                  onTap: () {},
                ),
              ],
            ),
            Gap(20.h),
            MoreSectionCard(
              title: 'more.sections.support_info'.tr(),
              items: [
                MoreItemTile(
                  icon: LucideIcons.fileText,
                  label: 'more.items.policies'.tr(),
                  subtitle: 'more.items.policies_sub'.tr(),
                  onTap: () {},
                ),
                MoreItemTile(
                  icon: LucideIcons.info,
                  label: 'more.items.about_us'.tr(),
                  subtitle: 'more.items.about_us_sub'.tr(),
                  onTap: () {},
                ),
                MoreItemTile(
                  icon: LucideIcons.mail,
                  label: 'more.items.contact_us'.tr(),
                  subtitle: 'more.items.contact_us_sub'.tr(),
                  onTap: () {},
                ),
              ],
            ),
            Gap(20.h),
            MoreSectionCard(
              title: 'more.sections.preferences'.tr(),
              items: [
                MoreItemTile(
                  icon: LucideIcons.bell,
                  label: 'more.items.notifications'.tr(),
                  onTap: () {},
                ),
                MoreItemTile(
                  icon: LucideIcons.globe,
                  label: 'more.items.language'.tr(),
                  subtitle: currentLanguage,
                  onTap: onLanguageTap ?? () => _toggleLanguage(context),
                ),
                MoreItemTile(
                  icon: LucideIcons.settings,
                  label: 'more.items.settings'.tr(),
                  onTap: () {},
                ),
              ],
            ),
            if (!profile.isGuest) ...[
              Gap(24.h),
              SignOutButton(onSignOutTap: onSignOutTap),
            ],
            Gap(36.h),
          ],
        ),
      ),
    );
  }

  void _toggleLanguage(BuildContext context) {
    final newLocale = context.locale.languageCode == 'en'
        ? const Locale('ar')
        : const Locale('en');
    context.setLocale(newLocale);
  }
}
