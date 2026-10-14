import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/network/dio_factory.dart';
import 'package:looks_loop/core/network/network_helper.dart';
import 'package:looks_loop/features/product_list/data/datasources/product_list_remote_data_source.dart';
import 'package:looks_loop/features/product_list/data/repositories/product_list_repository_impl.dart';
import 'package:looks_loop/features/product_list/domain/repositories/product_list_repository.dart';
import 'package:looks_loop/features/product_list/domain/usecases/get_products_usecase.dart';
import 'package:looks_loop/features/product_list/presentation/bloc/product_list_cubit.dart';

void registerProductListDependencies() {
  getIt.registerLazySingleton<ProductListRemoteDataSource>(
    () => ProductListRemoteDataSourceImpl(NetworkHelper(DioFactory.getDio())),
  );

  getIt.registerLazySingleton<ProductListRepository>(
    () => ProductListRepositoryImpl(getIt<ProductListRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(getIt<ProductListRepository>()),
  );

  getIt.registerFactory<ProductListCubit>(
    () => ProductListCubit(getIt<GetProductsUseCase>()),
  );
}
