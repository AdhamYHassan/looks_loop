import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/main/domain/entities/main_tab.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_cubit.dart';

class CheckoutSuccessSheet extends StatelessWidget {
  final String orderNumber;

  const CheckoutSuccessSheet({super.key, required this.orderNumber});

  static Future<void> show(BuildContext context, {required String orderNumber}) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: ColorManager.getBackground(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => CheckoutSuccessSheet(orderNumber: orderNumber),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _navigateToHome(context);
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56.w,
                height: 56.h,
                decoration: const BoxDecoration(
                  color: ColorManager.olive,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: ColorManager.cream,
                  size: 32,
                ),
              ),
              Gap(16.h),
              Text(
                'checkout.order_success_title'.tr(),
                textAlign: TextAlign.center,
                style: TextStyles.font20Bold(context).copyWith(fontSize: 18.sp),
              ),
              if (orderNumber.isNotEmpty) ...[
                Gap(6.h),
                Text(
                  'checkout.order_number'.tr(args: [orderNumber]),
                  style: TextStyles.font14SemiBold(context).copyWith(
                    color: ColorManager.olive,
                  ),
                ),
              ],
              Gap(8.h),
              Text(
                'checkout.order_success_message'.tr(),
                textAlign: TextAlign.center,
                style: TextStyles.font13MutedMedium(context),
              ),
              Gap(24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.olive,
                    foregroundColor: ColorManager.cream,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  onPressed: () => _navigateToOrders(context),
                  child: Text(
                    'checkout.go_to_orders'.tr().toUpperCase(),
                    style: TextStyles.font14SemiBold(context).copyWith(
                      color: ColorManager.cream,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
              Gap(8.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorManager.getText(context),
                    side: BorderSide(color: ColorManager.getBorder(context)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  onPressed: () => _navigateToHome(context),
                  child: Text(
                    'checkout.back_to_home'.tr().toUpperCase(),
                    style: TextStyles.font14SemiBold(context).copyWith(
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToOrders(BuildContext context) {
    getIt<MainCubit>().changeTab(MainTab.more);
    context.go(Routes.main);
    context.push(Routes.orders);
  }

  void _navigateToHome(BuildContext context) {
    getIt<MainCubit>().changeTab(MainTab.home);
    context.go(Routes.main);
  }
}
