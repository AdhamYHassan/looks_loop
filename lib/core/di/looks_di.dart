import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/network/dio_factory.dart';
import 'package:looks_loop/core/network/network_helper.dart';
import 'package:looks_loop/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:looks_loop/features/looks/data/datasources/looks_remote_data_source.dart';
import 'package:looks_loop/features/looks/data/repositories/looks_repository_impl.dart';
import 'package:looks_loop/features/looks/domain/repositories/looks_repository.dart';
import 'package:looks_loop/features/looks/domain/usecases/add_look_product_to_cart_usecase.dart';
import 'package:looks_loop/features/looks/domain/usecases/get_look_detail_usecase.dart';
import 'package:looks_loop/features/looks/domain/usecases/get_looks_usecase.dart';
import 'package:looks_loop/features/looks/presentation/bloc/look_detail_cubit.dart';
import 'package:looks_loop/features/looks/presentation/bloc/looks_cubit.dart';
import 'package:looks_loop/features/product_detail/domain/usecases/get_product_detail_usecase.dart';

void registerLooksDependencies() {
  // Data Source
  getIt.registerLazySingleton<LooksRemoteDataSource>(
    () => LooksRemoteDataSourceImpl(NetworkHelper(DioFactory.getDio())),
  );

  // Repository
  getIt.registerLazySingleton<LooksRepository>(
    () => LooksRepositoryImpl(getIt<LooksRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetLooksUseCase>(
    () => GetLooksUseCase(getIt<LooksRepository>()),
  );
  getIt.registerLazySingleton<GetLookDetailUseCase>(
    () => GetLookDetailUseCase(getIt<LooksRepository>()),
  );
  getIt.registerLazySingleton<AddLookProductToCartUseCase>(
    () => AddLookProductToCartUseCase(
      getIt<GetProductDetailUseCase>(),
      getIt<AddToCartUseCase>(),
    ),
  );

  // Cubits
  getIt.registerFactory<LooksCubit>(
    () => LooksCubit(getIt<GetLooksUseCase>()),
  );
  getIt.registerFactory<LookDetailCubit>(
    () => LookDetailCubit(
      getIt<GetLookDetailUseCase>(),
      getIt<AddLookProductToCartUseCase>(),
    ),
  );
}
