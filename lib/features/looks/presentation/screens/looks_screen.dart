import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/looks/presentation/bloc/looks_cubit.dart';
import 'package:looks_loop/features/looks/presentation/bloc/looks_state.dart';
import 'package:looks_loop/features/looks/presentation/widgets/look_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LooksScreen extends StatefulWidget {
  const LooksScreen({super.key});

  @override
  State<LooksScreen> createState() => _LooksScreenState();
}

class _LooksScreenState extends State<LooksScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LooksCubit>().fetchLooks();
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
        appBar: AppBar(
          backgroundColor: ColorManager.ink,
          elevation: 0,
          leading: IconButton(
            icon: Icon(LucideIcons.arrowLeft, color: Colors.white, size: 20.sp),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'SHOP THE LOOK',
            style: TextStyles.font13WhiteBlack.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<LooksCubit, LooksState>(
          builder: (context, state) {
            return switch (state) {
              LooksInitial() || LooksLoading() => Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.olive,
                    strokeWidth: 2.w,
                  ),
                ),
              LooksError(:final message) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message,
                        style: TextStyle(color: Colors.red, fontSize: 13.sp),
                      ),
                      Gap(12.h),
                      ElevatedButton(
                        onPressed: () => context.read<LooksCubit>().fetchLooks(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              LooksLoaded(:final looks) => GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 14.h,
                    childAspectRatio: 0.58,
                  ),
                  itemCount: looks.length,
                  itemBuilder: (context, index) {
                    final look = looks[index];
                    return LookCard(
                      look: look,
                      onShopTap: () => context.push(
                        Routes.lookProducts,
                        extra: look.slug,
                      ),
                    );
                  },
                ),
            };
          },
        ),
      ),
    );
  }
}
