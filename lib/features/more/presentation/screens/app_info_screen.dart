import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/more/presentation/bloc/app_info_cubit.dart';
import 'package:looks_loop/features/more/presentation/bloc/app_info_state.dart';
import 'package:looks_loop/features/more/presentation/widgets/app_info_content.dart';

class AppInfoScreen extends StatelessWidget {
  final AppInfoType type;

  const AppInfoScreen({super.key, required this.type});

  String _getTitle() {
    return switch (type) {
      AppInfoType.aboutUs => 'more.items.about_us'.tr(),
      AppInfoType.policy => 'more.items.policies'.tr(),
    };
  }

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
                  _getTitle(),
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
                child: BlocBuilder<AppInfoCubit, AppInfoState>(
                  builder: (context, state) {
                    return switch (state) {
                      AppInfoInitial() || AppInfoLoading() => Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.olive,
                            strokeWidth: 2.w,
                          ),
                        ),
                      AppInfoError(:final message) => Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                message,
                                style:
                                    TextStyles.font13TextBold(context).copyWith(
                                  color: Colors.red,
                                ),
                              ),
                              Gap(12.h),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<AppInfoCubit>()
                                    .loadInfo(type),
                                child: Text('common.retry'.tr()),
                              ),
                            ],
                          ),
                        ),
                      AppInfoLoaded(:final appInfo) =>
                        AppInfoContent(appInfo: appInfo),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

