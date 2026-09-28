import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/wishlist/presentation/widgets/wishlist_browse_button.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class WishlistEmptyView extends StatelessWidget {
  final VoidCallback? onBrowseTap;

  const WishlistEmptyView({super.key, this.onBrowseTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.heart,
            size: 52.sp,
            color: ColorManager.getTextMuted(context).withValues(alpha: 0.5),
          ),
          Gap(16.h),
          Text(
            'Your wishlist is empty',
            style: TextStyles.font20Bold(context),
          ),
          Gap(6.h),
          Text(
            'Save your favorite pieces by tapping the heart icon.',
            textAlign: TextAlign.center,
            style: TextStyles.font13MutedMedium(context),
          ),
          Gap(28.h),
          WishlistBrowseButton(onTap: onBrowseTap),
        ],
      ),
    );
  }
}
