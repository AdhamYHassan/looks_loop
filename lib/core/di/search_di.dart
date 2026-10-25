import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/network/dio_factory.dart';
import 'package:looks_loop/features/search/data/datasources/search_remote_data_source.dart';
import 'package:looks_loop/features/search/data/repositories/search_repository_impl.dart';
import 'package:looks_loop/features/search/domain/repositories/search_repository.dart';
import 'package:looks_loop/features/search/domain/usecases/search_catalog_usecase.dart';
import 'package:looks_loop/features/search/presentation/bloc/search_cubit.dart';

void registerSearchDependencies() {
  getIt.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(DioFactory.getDio()),
  );

  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(getIt<SearchRemoteDataSource>()),
  );

  getIt.registerLazySingleton<SearchCatalogUseCase>(
    () => SearchCatalogUseCase(getIt<SearchRepository>()),
  );

  getIt.registerFactory<SearchCubit>(
    () => SearchCubit(getIt<SearchCatalogUseCase>()),
  );
}

