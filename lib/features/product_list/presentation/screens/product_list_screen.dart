import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/product_list/domain/entities/product_list_args.dart';
import 'package:looks_loop/features/product_list/presentation/bloc/product_list_cubit.dart';
import 'package:looks_loop/features/product_list/presentation/bloc/product_list_state.dart';
import 'package:looks_loop/features/product_list/presentation/widgets/product_list_body.dart';
import 'package:looks_loop/features/product_list/presentation/widgets/product_list_sub_nav_bar.dart';

class ProductListScreen extends StatefulWidget {
  final ProductListArgs args;

  const ProductListScreen({super.key, required this.args});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 300) {
      context.read<ProductListCubit>().loadMore();
    }
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
                color: ColorManager.ink,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AnnouncementBar(
                        text: 'DISCOVER LOCAL & INTERNATIONAL BRANDS',
                      ),
                      ProductListSubNavBar(
                        title:
                            '${widget.args.categoryTitle} / ${widget.args.subcategoryTitle}',
                        onSearchSubmitted: (q) =>
                            context.read<ProductListCubit>().search(q),
                        onSearchCleared: () =>
                            context.read<ProductListCubit>().search(''),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<ProductListCubit, ProductListState>(
                  builder: (context, state) {
                    return switch (state) {
                      ProductListInitial() || ProductListLoading() => Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.olive,
                            strokeWidth: 2.w,
                          ),
                        ),
                      ProductListError(:final message) =>
                        _buildErrorState(context, message),
                      ProductListLoaded() => ProductListBody(
                          args: widget.args,
                          state: state,
                          scrollController: _scrollController,
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

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: TextStyle(color: Colors.red, fontSize: 13.sp)),
          Gap(12.h),
          ElevatedButton(
            onPressed: () => context.read<ProductListCubit>().loadProducts(
                  category: widget.args.categorySlug,
                  subcategory: widget.args.subcategorySlug,
                ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
