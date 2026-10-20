import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/looks/presentation/bloc/look_detail_cubit.dart';
import 'package:looks_loop/features/looks/presentation/bloc/look_detail_state.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LookProductsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int initialCount;

  const LookProductsAppBar({super.key, this.initialCount = 0});

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.getBackground(context),
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          LucideIcons.arrowLeft,
          color: ColorManager.getText(context),
          size: 20.sp,
        ),
        onPressed: () => context.pop(),
      ),
      title: BlocBuilder<LookDetailCubit, LookDetailState>(
        builder: (context, state) {
          final count = state is LookDetailLoaded
              ? state.look.hotspots.length
              : initialCount;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'SHOP THE LOOK',
                style: TextStyles.font13TextBold(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              if (count > 0) ...[
                Gap(2.h),
                Text(
                  '$count pieces',
                  style: TextStyles.font13MutedMedium(context).copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          );
        },
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            LucideIcons.x,
            color: ColorManager.getText(context),
            size: 20.sp,
          ),
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}
