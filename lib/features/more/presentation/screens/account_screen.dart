import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/app_snack_bar.dart';
import 'package:looks_loop/features/more/presentation/bloc/account_cubit.dart';
import 'package:looks_loop/features/more/presentation/bloc/account_state.dart';
import 'package:looks_loop/features/more/presentation/widgets/account_form_content.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = ColorManager.isDark(context);

    return Scaffold(
      backgroundColor: ColorManager.getBackground(context),
      appBar: AppBar(
        title: Text(
          'account.title'.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: ColorManager.getText(context),
            fontFamily: 'Cairo',
          ),
        ),
        centerTitle: true,
        backgroundColor:
            isDark ? ColorManager.surfaceDark : ColorManager.surfaceLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            LucideIcons.arrowLeft,
            color: ColorManager.getText(context),
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {
          if (state is AccountUpdateSuccess) {
            AppSnackBar.showSuccess(
              context,
              message: 'account.update_success'.tr(),
            );
          } else if (state is AccountError) {
            AppSnackBar.showError(
              context,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          return switch (state) {
            AccountInitial() || AccountLoading() => Center(
                child: CircularProgressIndicator(
                  color: ColorManager.olive,
                  strokeWidth: 2.w,
                ),
              ),
            AccountError(:final message) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message,
                      style: TextStyle(color: Colors.red, fontSize: 13.sp),
                    ),
                    SizedBox(height: 12.h),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<AccountCubit>().fetchProfile(),
                      child: Text('common.retry'.tr()),
                    ),
                  ],
                ),
              ),
            AccountLoaded(:final profile) => AccountFormContent(
                profile: profile,
                isUpdating: false,
                onSubmit: (params) =>
                    context.read<AccountCubit>().updateProfile(params),
              ),
            AccountUpdating(:final currentProfile) => AccountFormContent(
                profile: currentProfile,
                isUpdating: true,
                onSubmit: (params) =>
                    context.read<AccountCubit>().updateProfile(params),
              ),
            AccountUpdateSuccess(:final profile) => AccountFormContent(
                profile: profile,
                isUpdating: false,
                onSubmit: (params) =>
                    context.read<AccountCubit>().updateProfile(params),
              ),
          };
        },
      ),
    );
  }
}
