import 'package:flutter/painting.dart';
import 'package:get_it/get_it.dart';
import 'package:looks_loop/core/helpers/shared_prefs_helper.dart';
import 'package:looks_loop/core/theming/theme_cubit.dart';
import 'package:looks_loop/features/home/data/datasources/home_remote_data_source.dart';
import 'package:looks_loop/features/home/data/repositories/home_repository_impl.dart';
import 'package:looks_loop/features/home/domain/repositories/home_repository.dart';
import 'package:looks_loop/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_cubit.dart';
import 'package:looks_loop/features/main/presentation/bloc/main_cubit.dart';
import 'package:looks_loop/features/main/presentation/bloc/nav_bar_scroll_cubit.dart';
import 'package:looks_loop/features/shop/data/datasources/shop_remote_data_source.dart';
import 'package:looks_loop/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:looks_loop/features/shop/domain/repositories/shop_repository.dart';
import 'package:looks_loop/features/shop/domain/usecases/get_shop_feed_usecase.dart';
import 'package:looks_loop/features/shop/presentation/bloc/shop_cubit.dart';
import 'package:looks_loop/features/more/data/datasources/more_local_data_source.dart';
import 'package:looks_loop/features/more/data/repositories/more_repository_impl.dart';
import 'package:looks_loop/features/more/domain/repositories/more_repository.dart';
import 'package:looks_loop/features/more/domain/usecases/get_user_profile_usecase.dart';
import 'package:looks_loop/features/more/presentation/bloc/more_cubit.dart';
import 'package:looks_loop/features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:looks_loop/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:looks_loop/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:looks_loop/features/wishlist/presentation/bloc/wishlist_cubit.dart';
import 'package:looks_loop/features/shop/data/datasources/category_detail_remote_data_source.dart';
import 'package:looks_loop/features/shop/data/repositories/category_detail_repository_impl.dart';
import 'package:looks_loop/features/shop/domain/repositories/category_detail_repository.dart';
import 'package:looks_loop/features/shop/domain/usecases/get_category_detail_usecase.dart';
import 'package:looks_loop/features/shop/presentation/bloc/category_detail_cubit.dart';
import 'package:looks_loop/core/network/dio_factory.dart';
import 'package:looks_loop/core/network/network_helper.dart';
import 'package:looks_loop/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:looks_loop/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:looks_loop/features/auth/domain/repositories/auth_repository.dart';
import 'package:looks_loop/features/auth/domain/usecases/login_usecase.dart';
import 'package:looks_loop/features/auth/domain/usecases/logout_usecase.dart';
import 'package:looks_loop/features/auth/presentation/bloc/login_cubit.dart';

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
  getIt.registerLazySingleton<MoreLocalDataSource>(
    () => const MoreLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<CategoryDetailRemoteDataSource>(
    () => const CategoryDetailRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(NetworkHelper(DioFactory.getDio())),
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
  getIt.registerLazySingleton<MoreRepository>(
    () => MoreRepositoryImpl(getIt<MoreLocalDataSource>()),
  );
  getIt.registerLazySingleton<CategoryDetailRepository>(
    () => CategoryDetailRepositoryImpl(
      getIt<CategoryDetailRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
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
  getIt.registerLazySingleton<GetUserProfileUseCase>(
    () => GetUserProfileUseCase(getIt<MoreRepository>()),
  );
  getIt.registerLazySingleton<GetCategoryDetailUseCase>(
    () => GetCategoryDetailUseCase(getIt<CategoryDetailRepository>()),
  );
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<AuthRepository>()),
  );

  // Cubits / Blocs (Factory)
  getIt.registerFactory<MainCubit>(() => MainCubit());
  getIt.registerFactory<NavBarScrollCubit>(() => NavBarScrollCubit());
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
  getIt.registerFactory<MoreCubit>(
    () => MoreCubit(
      getIt<GetUserProfileUseCase>(),
      getIt<LogoutUseCase>(),
    ),
  );
  getIt.registerFactory<CategoryDetailCubit>(
    () => CategoryDetailCubit(getIt<GetCategoryDetailUseCase>()),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<LoginUseCase>()),
  );
}
