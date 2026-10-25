import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/home/presentation/widgets/home_error_view.dart';
import 'package:looks_loop/features/search/presentation/bloc/search_cubit.dart';
import 'package:looks_loop/features/search/presentation/bloc/search_state.dart';
import 'package:looks_loop/features/search/presentation/widgets/search_empty_view.dart';
import 'package:looks_loop/features/search/presentation/widgets/search_filter_chips.dart';
import 'package:looks_loop/features/search/presentation/widgets/search_header_bar.dart';
import 'package:looks_loop/features/search/presentation/widgets/search_initial_view.dart';
import 'package:looks_loop/features/search/presentation/widgets/search_results_grid.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_cubit.dart';

class SearchModalView extends StatefulWidget {
  const SearchModalView({super.key});

  static Future<void> show(BuildContext context) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (ctx, anim1, anim2) => const SearchModalView(),
      transitionBuilder: (ctx, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.05),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic)),
          child: FadeTransition(opacity: anim1, child: child),
        );
      },
    );
  }

  @override
  State<SearchModalView> createState() => _SearchModalViewState();
}

class _SearchModalViewState extends State<SearchModalView> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(
          create: (_) => getIt<SearchCubit>(),
        ),
        BlocProvider<WishlistCubit>.value(
          value: getIt<WishlistCubit>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: ColorManager.getBackground(context),
        body: SafeArea(
          child: Builder(
            builder: (ctx) {
              final cubit = ctx.read<SearchCubit>();
              return Column(
                children: [
                  SearchHeaderBar(
                    controller: _controller,
                    focusNode: _focusNode,
                    onChanged: cubit.onQueryChanged,
                    onClear: () {
                      _controller.clear();
                      cubit.clearSearch();
                    },
                    onClose: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        return switch (state) {
                          SearchInitial() => const SearchInitialView(),
                          SearchLoading() => const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          SearchEmpty(:final query) =>
                            SearchEmptyView(query: query),
                          SearchError(:final message) => HomeErrorView(
                              message: message,
                              onRetry: () =>
                                  cubit.onQueryChanged(_controller.text),
                            ),
                          SearchLoaded(:final results) => Column(
                              children: [
                                SearchFilterChips(
                                  brands: results.brands,
                                  categories: results.categories,
                                ),
                                Expanded(
                                  child: SearchResultsGrid(
                                    products: results.products,
                                  ),
                                ),
                              ],
                            ),
                        };
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
