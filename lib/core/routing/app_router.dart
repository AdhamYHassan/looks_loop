import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_cubit.dart';
import 'package:looks_loop/features/home/presentation/screens/home_screen.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_cubit.dart';
import 'package:looks_loop/features/main/presentation/screens/main_screen.dart';
import 'package:looks_loop/features/shop/presentation/bloc/shop_cubit.dart';
import 'package:looks_loop/features/shop/presentation/screens/shop_screen.dart';
import 'package:looks_loop/features/more/presentation/bloc/more_cubit.dart';
import 'package:looks_loop/features/more/presentation/screens/more_screen.dart';
import 'package:looks_loop/features/splash/presentation/splash_screen.dart';
import 'package:looks_loop/features/shop/domain/entities/shop_feed_entities.dart';
import 'package:looks_loop/features/shop/presentation/bloc/category_detail_cubit.dart';
import 'package:looks_loop/features/shop/presentation/screens/category_detail_screen.dart';
import 'package:looks_loop/features/cart/presentation/screens/cart_screen.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_cubit.dart';
import 'package:looks_loop/features/wishlist/presentation/screens/wishlist_screen.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class AppRouter {
  AppRouter._();

  static Page<dynamic> _buildPageWithTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static const String initialRoute = Routes.splash;

  static final GoRouter router = GoRouter(
    initialLocation: initialRoute,
    observers: [routeObserver],
    routes: [
      GoRoute(
        path: Routes.splash,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: Routes.main,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<MainCubit>()),
              BlocProvider(create: (_) => getIt<HomeCubit>()..fetchHomeFeed()),
              BlocProvider(create: (_) => getIt<ShopCubit>()..fetchShopFeed()),
              BlocProvider(create: (_) => getIt<WishlistCubit>()..fetchWishlist()),
              BlocProvider(create: (_) => getIt<MoreCubit>()..loadUserProfile()),
            ],
            child: const MainScreen(),
          ),
        ),
      ),
      GoRoute(
        path: Routes.home,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (_) => getIt<HomeCubit>()..fetchHomeFeed(),
            child: const HomeScreen(),
          ),
        ),
      ),
      GoRoute(
        path: Routes.shop,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (_) => getIt<ShopCubit>()..fetchShopFeed(),
            child: const ShopScreen(),
          ),
        ),
      ),
      GoRoute(
        path: Routes.wishlist,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (_) => getIt<WishlistCubit>()..fetchWishlist(),
            child: const WishlistScreen(),
          ),
        ),
      ),
      GoRoute(
        path: Routes.more,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (_) => getIt<MoreCubit>()..loadUserProfile(),
            child: const MoreScreen(),
          ),
        ),
      ),
      GoRoute(
        path: Routes.categoryDetail,
        pageBuilder: (context, state) {
          final audience = state.extra as ShopAudienceEntity? ??
              const ShopAudienceEntity(
                id: 'aud_women',
                title: 'WOMEN',
                imageUrl: '',
              );
          return _buildPageWithTransition(
            context: context,
            state: state,
            child: BlocProvider(
              create: (_) => getIt<CategoryDetailCubit>()
                ..loadCategoryDetail(audience.id),
              child: CategoryDetailScreen(audience: audience),
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.cart,
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          child: const CartScreen(),
        ),
      ),
    ],
  );
}
