import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/auth/auth_status_cubit.dart';
import 'package:looks_loop/core/auth/auth_status_state.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/responsive_content_wrapper.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/more/presentation/widgets/settings_content.dart';

class SettingsScreen extends StatelessWidget {
  final bool isGuest;

  const SettingsScreen({super.key, this.isGuest = false});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: ColorManager.getBackground(context),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Container(
                color: ColorManager.olive,
                child: SafeArea(
                  bottom: false,
                  child: AnnouncementBar(text: 'more.easy_returns'.tr()),
                ),
              ),
              AppBar(
                primary: false,
                backgroundColor: ColorManager.getBackground(context),
                elevation: 0,
                scrolledUnderElevation: 0,
                title: Text(
                  'settings.title'.tr(),
                  style: TextStyles.font18SemiBold(context),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 18.w,
                    color: ColorManager.getText(context),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Expanded(
                child: ResponsiveContentWrapper(
                  child: BlocBuilder<AuthStatusCubit, AuthStatusState>(
                    builder: (context, authState) {
                      final effectiveIsGuest = switch (authState) {
                        AuthStatusAuthenticated() => false,
                        AuthStatusGuest() || AuthStatusInitial() => true,
                      };
                      return SettingsContent(isGuest: effectiveIsGuest);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
