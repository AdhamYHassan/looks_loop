import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/theme_cubit.dart';
import 'package:looks_loop/features/more/presentation/widgets/more_item_tile.dart';
import 'package:looks_loop/features/more/presentation/widgets/more_section_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MorePreferencesSection extends StatelessWidget {
  final VoidCallback? onLanguageTap;

  const MorePreferencesSection({
    super.key,
    this.onLanguageTap,
  });

  @override
  Widget build(BuildContext context) {
    final localeCode =
        Localizations.maybeLocaleOf(context)?.languageCode ?? 'en';
    final currentLanguage = localeCode == 'ar' ? 'العربية' : 'English';
    final isDarkMode = ColorManager.isDark(context);

    return MoreSectionCard(
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
          icon: isDarkMode ? LucideIcons.moon : LucideIcons.sun,
          label: 'more.items.theme'.tr(),
          subtitle: isDarkMode
              ? 'more.items.dark_mode'.tr()
              : 'more.items.light_mode'.tr(),
          trailing: Switch.adaptive(
            value: isDarkMode,
            activeTrackColor: ColorManager.olive,
            activeThumbColor: ColorManager.cream,
            onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
          ),
          onTap: () => context.read<ThemeCubit>().toggleTheme(),
        ),
        MoreItemTile(
          icon: LucideIcons.settings,
          label: 'more.items.settings'.tr(),
          onTap: () {},
        ),
      ],
    );
  }

  void _toggleLanguage(BuildContext context) {
    final newLocale = context.locale.languageCode == 'en'
        ? const Locale('ar')
        : const Locale('en');
    context.setLocale(newLocale);
  }
}
