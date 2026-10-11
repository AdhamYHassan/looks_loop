import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/features/home/presentation/screens/home_screen.dart';
import 'package:looks_loop/features/main/domain/entities/main_tab.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_cubit.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_state.dart';
import 'package:looks_loop/features/main/presentation/bloc/nav_bar_scroll_cubit.dart';
import 'package:looks_loop/features/main/presentation/widgets/dynamic_floating_nav_bar.dart';
import 'package:looks_loop/features/main/presentation/widgets/reels_placeholder_view.dart';
import 'package:looks_loop/features/more/presentation/bloc/more_cubit.dart';
import 'package:looks_loop/features/more/presentation/bloc/more_state.dart';
import 'package:looks_loop/features/more/presentation/screens/more_screen.dart';
import 'package:looks_loop/features/shop/presentation/bloc/shop_cubit.dart';
import 'package:looks_loop/features/shop/presentation/bloc/shop_state.dart';
import 'package:looks_loop/features/shop/presentation/screens/shop_screen.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_cubit.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:looks_loop/features/wishlist/presentation/screens/wishlist_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Set<int> _visitedIndices = {0};

  void _onTabChanged(BuildContext context, MainTab tab, int index) {
    if (!_visitedIndices.contains(index)) {
      setState(() => _visitedIndices.add(index));
    }

    switch (tab) {
      case MainTab.home:
      case MainTab.reels:
        break;
      case MainTab.shop:
        final cubit = context.read<ShopCubit>();
        if (cubit.state is ShopInitial) {
          cubit.fetchShopFeed();
        }
      case MainTab.wishlist:
        final cubit = context.read<WishlistCubit>();
        if (cubit.state is WishlistInitial) {
          cubit.fetchWishlist();
        }
      case MainTab.more:
        final cubit = context.read<MoreCubit>();
        if (cubit.state is MoreInitial) {
          cubit.loadUserProfile();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NavBarScrollCubit>(),
      child: Builder(
        builder: (context) {
          return BlocListener<MainCubit, MainState>(
            listenWhen: (prev, curr) => prev.currentTab != curr.currentTab,
            listener: (context, state) {
              context.read<NavBarScrollCubit>().reset();
              _onTabChanged(context, state.currentTab, state.selectedIndex);
            },
            child: Scaffold(
              extendBody: true,
              body: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.axis == Axis.vertical) {
                    context
                        .read<NavBarScrollCubit>()
                        .onScrollOffsetChanged(notification.metrics.pixels);
                  }
                  return false;
                },
                child: BlocBuilder<MainCubit, MainState>(
                  buildWhen: (prev, curr) =>
                      prev.selectedIndex != curr.selectedIndex,
                  builder: (context, state) {
                    return IndexedStack(
                      index: state.selectedIndex,
                      children: [
                        const HomeScreen(showBottomNavBar: false),
                        _visitedIndices.contains(1)
                            ? const ReelsPlaceholderView()
                            : const SizedBox.shrink(),
                        _visitedIndices.contains(2)
                            ? const ShopScreen(showBottomNavBar: false)
                            : const SizedBox.shrink(),
                        _visitedIndices.contains(3)
                            ? const WishlistScreen(showBottomNavBar: false)
                            : const SizedBox.shrink(),
                        _visitedIndices.contains(4)
                            ? const MoreScreen(showBottomNavBar: false)
                            : const SizedBox.shrink(),
                      ],
                    );
                  },
                ),
              ),
              bottomNavigationBar: const DynamicFloatingNavBar(),
            ),
          );
        },
      ),
    );
  }
}
