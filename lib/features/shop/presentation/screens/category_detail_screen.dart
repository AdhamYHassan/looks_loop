import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/shop/presentation/bloc/category_detail_cubit.dart';
import 'package:looks_loop/features/shop/presentation/bloc/category_detail_state.dart';
import 'package:looks_loop/features/shop/presentation/widgets/category_detail_body.dart';
import 'package:looks_loop/features/shop/presentation/widgets/category_sub_nav_bar.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String title;
  final String id;
  final String slug;

  const CategoryDetailScreen({
    super.key,
    required this.title,
    required this.id,
    this.slug = '',
  });

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
                color: ColorManager.ink,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AnnouncementBar(),
                      CategorySubNavBar(title: title),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<CategoryDetailCubit, CategoryDetailState>(
                  builder: (context, state) {
                    return switch (state) {
                      CategoryDetailInitial() || CategoryDetailLoading() =>
                        Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.olive,
                            strokeWidth: 2.w,
                          ),
                        ),
                      CategoryDetailError(:final message) => Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                message,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13.sp,
                                ),
                              ),
                              Gap(12.h),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<CategoryDetailCubit>()
                                    .loadCategoryDetail(id),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      CategoryDetailLoaded(
                        :final data,
                        :final wishlistedProductIds,
                      ) =>
                        CategoryDetailBody(
                          data: data,
                          wishlistedProductIds: wishlistedProductIds,
                          title: title,
                          id: id,
                          slug: slug,
                        ),
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
