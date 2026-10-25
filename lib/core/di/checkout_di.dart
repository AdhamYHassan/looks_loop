import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/network/dio_factory.dart';
import 'package:looks_loop/core/network/network_helper.dart';
import 'package:looks_loop/features/checkout/data/datasources/checkout_remote_data_source.dart';
import 'package:looks_loop/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:looks_loop/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:looks_loop/features/checkout/domain/usecases/get_delivery_methods_usecase.dart';
import 'package:looks_loop/features/checkout/domain/usecases/get_payment_methods_usecase.dart';
import 'package:looks_loop/features/checkout/domain/usecases/place_order_usecase.dart';
import 'package:looks_loop/features/checkout/presentation/bloc/checkout_cubit.dart';

void registerCheckoutDependencies() {
  getIt.registerLazySingleton<CheckoutRemoteDataSource>(
    () => CheckoutRemoteDataSourceImpl(NetworkHelper(DioFactory.getDio())),
  );

  getIt.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepositoryImpl(getIt<CheckoutRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetDeliveryMethodsUseCase>(
    () => GetDeliveryMethodsUseCase(getIt<CheckoutRepository>()),
  );

  getIt.registerLazySingleton<GetPaymentMethodsUseCase>(
    () => GetPaymentMethodsUseCase(getIt<CheckoutRepository>()),
  );

  getIt.registerLazySingleton<PlaceOrderUseCase>(
    () => PlaceOrderUseCase(getIt<CheckoutRepository>()),
  );

  getIt.registerFactory<CheckoutCubit>(
    () => CheckoutCubit(
      getIt<GetDeliveryMethodsUseCase>(),
      getIt<GetPaymentMethodsUseCase>(),
      getIt<PlaceOrderUseCase>(),
    ),
  );
}
