import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/features/address/domain/usecases/add_address_usecase.dart';
import 'package:looks_loop/features/address/domain/usecases/get_addresses_usecase.dart';
import 'package:looks_loop/features/address/domain/usecases/get_provinces_usecase.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_cubit.dart';
import 'package:looks_loop/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:looks_loop/features/checkout/presentation/bloc/checkout_cubit.dart';
import 'package:looks_loop/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_success_sheet.dart';
import '../checkout_delivery_test_fixtures.dart';
import '../checkout_test_fixtures.dart';

void main() {
  Widget createWidgetUnderTest({
    required CheckoutCubit checkoutCubit,
    required AddressCubit addressCubit,
    required CartCubit cartCubit,
  }) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, _) => MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: checkoutCubit),
            BlocProvider.value(value: addressCubit),
            BlocProvider.value(value: cartCubit),
          ],
          child: const CheckoutScreen(),
        ),
      ),
    );
  }

  testWidgets('renders all 4 checkout steps and places order', (tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final repo = FakeCheckoutAddressRepo(
      [dummyCheckoutAddress1, dummyCheckoutAddress2],
      provinces: const [dummyCairoProvince],
    );
    final addressCubit = AddressCubit(
      GetAddressesUseCase(repo),
      AddAddressUseCase(repo),
      GetProvincesUseCase(repo),
    );
    final checkoutCubit = CheckoutCubit(
      createTestGetDeliveryMethodsUseCase(),
      createTestGetPaymentMethodsUseCase(),
      createTestPlaceOrderUseCase(),
    );
    final cartCubit = createTestCartCubit(dummyCheckoutCart)..getCart();

    await tester.pumpWidget(createWidgetUnderTest(
      checkoutCubit: checkoutCubit,
      addressCubit: addressCubit,
      cartCubit: cartCubit,
    ));
    await tester.pumpAndSettle();

    // 1. Address Step
    expect(find.text('CHECKOUT'), findsOneWidget);
    expect(find.text('DELIVERY ADDRESS'), findsOneWidget);
    expect(find.text('CONTINUE'), findsOneWidget);

    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    // 2. Delivery Step
    expect(find.text('DELIVERY METHOD'), findsOneWidget);
    expect(find.text('STANDARD DELIVERY'), findsOneWidget);
    expect(find.text('CONTINUE TO PAYMENT'), findsOneWidget);

    await tester.tap(find.text('CONTINUE TO PAYMENT'));
    await tester.pumpAndSettle();

    // 3. Payment Step
    expect(find.text('PAYMENT METHOD'), findsOneWidget);
    expect(find.text('CASH ON DELIVERY'), findsOneWidget);
    expect(find.text('CONTINUE'), findsOneWidget);

    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    // 4. Review Step
    expect(find.text('REVIEW YOUR ORDER'), findsOneWidget);
    expect(find.text('ITEMS (1)'), findsOneWidget);
    expect(find.text('MANGO'), findsOneWidget);
    expect(find.text('Relaxed Linen Shirt'), findsOneWidget);
    expect(find.text('PRICE SUMMARY'), findsOneWidget);
    expect(find.text('PLACE ORDER'), findsOneWidget);

    // Edit link navigates back to Step 1
    await tester.tap(find.text('EDIT').first);
    await tester.pumpAndSettle();
    expect(find.text('DELIVERY ADDRESS'), findsOneWidget);

    // Tap EDIT on address card in Step 1
    await tester.tap(find.text('EDIT').first);
    await tester.pumpAndSettle();
    expect(find.text('Edit Address'), findsOneWidget);
    expect(find.text('Sarah'), findsOneWidget);
    expect(find.text('Ahmed'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, '01012345678'), findsOneWidget);

    // Close edit sheet to return to checkout
    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();

    // Navigate back to Review step
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUE TO PAYMENT'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    // Place order
    await tester.tap(find.text('PLACE ORDER'));
    await tester.pumpAndSettle();
    expect(find.byType(CheckoutSuccessSheet), findsOneWidget);
  });
}
