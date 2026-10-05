import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/features/home/presentation/screens/home_screen.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_cubit.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_state.dart';
import 'package:looks_loop/features/main/presentation/bloc/nav_bar_scroll_cubit.dart';
import 'package:looks_loop/features/main/presentation/widgets/dynamic_floating_nav_bar.dart';
import 'package:looks_loop/features/main/presentation/widgets/reels_placeholder_view.dart';
import 'package:looks_loop/features/more/presentation/screens/more_screen.dart';
import 'package:looks_loop/features/shop/presentation/screens/shop_screen.dart';
import 'package:looks_loop/features/wishlist/presentation/screens/wishlist_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const List<Widget> _tabs = [
    HomeScreen(showBottomNavBar: false),
    ReelsPlaceholderView(),
    ShopScreen(showBottomNavBar: false),
    WishlistScreen(showBottomNavBar: false),
    MoreScreen(showBottomNavBar: false),
  ];

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
                      children: _tabs,
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
