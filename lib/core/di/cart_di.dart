import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/network/dio_factory.dart';
import 'package:looks_loop/core/network/network_helper.dart';
import 'package:looks_loop/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:looks_loop/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:looks_loop/features/cart/domain/repositories/cart_repository.dart';
import 'package:looks_loop/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:looks_loop/features/cart/domain/usecases/apply_promo_code_usecase.dart';
import 'package:looks_loop/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:looks_loop/features/cart/domain/usecases/remove_cart_item_usecase.dart';
import 'package:looks_loop/features/cart/domain/usecases/remove_promo_code_usecase.dart';
import 'package:looks_loop/features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:looks_loop/features/cart/presentation/bloc/cart_cubit.dart';

void registerCartDependencies() {
  // Remote Data Source
  getIt.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(NetworkHelper(DioFactory.getDio())),
  );

  // Repository
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(getIt<CartRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetCartUseCase>(
    () => GetCartUseCase(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<AddToCartUseCase>(
    () => AddToCartUseCase(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<UpdateCartQuantityUseCase>(
    () => UpdateCartQuantityUseCase(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<RemoveCartItemUseCase>(
    () => RemoveCartItemUseCase(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<ApplyPromoCodeUseCase>(
    () => ApplyPromoCodeUseCase(getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<RemovePromoCodeUseCase>(
    () => RemovePromoCodeUseCase(getIt<CartRepository>()),
  );

  // Cubit
  getIt.registerLazySingleton<CartCubit>(
    () => CartCubit(
      getIt<GetCartUseCase>(),
      getIt<UpdateCartQuantityUseCase>(),
      getIt<RemoveCartItemUseCase>(),
      getIt<ApplyPromoCodeUseCase>(),
      getIt<RemovePromoCodeUseCase>(),
    ),
  );
}
