import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/loaders/loaders.dart';

class CartEmptyView extends StatelessWidget {
  final VoidCallback? onExplore;

  const CartEmptyView({
    super.key,
    this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = ColorManager.isDark(context);

    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LookAroundEyesLoader(
              width: 130.w,
              color: isDark ? ColorManager.cream : ColorManager.olive,
            ),
            SizedBox(height: 28.h),
            Text(
              'Your Bag is Looking Empty',
              textAlign: TextAlign.center,
              style: TextStyles.font20Bold(context).copyWith(
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Looks like you haven't added anything yet.\nExplore our latest runway drops and find your next look.",
              textAlign: TextAlign.center,
              style: TextStyles.font13MutedMedium(context).copyWith(
                height: 1.5,
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: () {
                if (onExplore != null) {
                  onExplore!();
                } else {
                  context.pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.olive,
                foregroundColor: ColorManager.cream,
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: 36.w,
                  vertical: 14.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: Text(
                'EXPLORE THE COLLECTION',
                style: TextStyles.font11Action(context).copyWith(
                  color: ColorManager.cream,
                  letterSpacing: 1.5.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
