import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/network/dio_factory.dart';
import 'package:looks_loop/core/network/network_helper.dart';
import 'package:looks_loop/features/brands/data/datasources/brands_remote_data_source.dart';
import 'package:looks_loop/features/brands/data/repositories/brands_repository_impl.dart';
import 'package:looks_loop/features/brands/domain/repositories/brands_repository.dart';
import 'package:looks_loop/features/brands/domain/usecases/get_brands_usecase.dart';
import 'package:looks_loop/features/brands/presentation/bloc/brands_cubit.dart';

void registerBrandsDependencies() {
  getIt.registerLazySingleton<BrandsRemoteDataSource>(
    () => BrandsRemoteDataSourceImpl(NetworkHelper(DioFactory.getDio())),
  );

  getIt.registerLazySingleton<BrandsRepository>(
    () => BrandsRepositoryImpl(getIt<BrandsRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetBrandsUseCase>(
    () => GetBrandsUseCase(getIt<BrandsRepository>()),
  );

  getIt.registerFactory<BrandsCubit>(
    () => BrandsCubit(getIt<GetBrandsUseCase>()),
  );
}
