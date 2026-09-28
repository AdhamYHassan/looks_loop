import 'package:flutter/painting.dart';
import 'package:get_it/get_it.dart';
import 'package:looks_loop/core/helpers/shared_prefs_helper.dart';
import 'package:looks_loop/core/theming/theme_cubit.dart';
import 'package:looks_loop/features/home/data/datasources/home_remote_data_source.dart';
import 'package:looks_loop/features/home/data/repositories/home_repository_impl.dart';
import 'package:looks_loop/features/home/domain/repositories/home_repository.dart';
import 'package:looks_loop/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_cubit.dart';
import 'package:looks_loop/features/shop/data/datasources/shop_remote_data_source.dart';
import 'package:looks_loop/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:looks_loop/features/shop/domain/repositories/shop_repository.dart';
import 'package:looks_loop/features/shop/domain/usecases/get_shop_feed_usecase.dart';
import 'package:looks_loop/features/shop/presentation/bloc/shop_cubit.dart';
import 'package:looks_loop/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:looks_loop/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:looks_loop/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_cubit.dart';

final getIt = GetIt.instance;

Future<void> initAppDependencies() async {
  // Shared Preferences
  await SharedPrefsHelper.init();

  // Engine Image Cache Configuration (max cache count and max bytes limit)
  PaintingBinding.instance.imageCache.maximumSize = 250;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 120 * 1024 * 1024;

  // Theming
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // Data Sources
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => const HomeRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ShopRemoteDataSource>(
    () => const ShopRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<WishlistRemoteDataSource>(
    () => WishlistRemoteDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeRemoteDataSource>()),
  );
  getIt.registerLazySingleton<ShopRepository>(
    () => ShopRepositoryImpl(getIt<ShopRemoteDataSource>()),
  );
  getIt.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(getIt<WishlistRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetHomeFeedUseCase>(
    () => GetHomeFeedUseCase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton<GetShopFeedUseCase>(
    () => GetShopFeedUseCase(getIt<ShopRepository>()),
  );
  getIt.registerLazySingleton<GetWishlistUseCase>(
    () => GetWishlistUseCase(getIt<WishlistRepository>()),
  );
  getIt.registerLazySingleton<RemoveFromWishlistUseCase>(
    () => RemoveFromWishlistUseCase(getIt<WishlistRepository>()),
  );

  // Cubits / Blocs (Factory)
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getIt<GetHomeFeedUseCase>()),
  );
  getIt.registerFactory<ShopCubit>(
    () => ShopCubit(getIt<GetShopFeedUseCase>()),
  );
  getIt.registerFactory<WishlistCubit>(
    () => WishlistCubit(
      getIt<GetWishlistUseCase>(),
      getIt<RemoveFromWishlistUseCase>(),
    ),
  );
}
