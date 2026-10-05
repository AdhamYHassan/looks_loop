import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/widgets/loaders/loaders.dart';
import 'package:looks_loop/features/cart/presentation/screens/cart_screen.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        home: child,
      ),
    );
  }

  group('CartScreen Smoke Tests', () {
    testWidgets('renders empty bag state with LookAroundEyesLoader', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const CartScreen()));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(CartScreen), findsOneWidget);
      expect(find.byType(LookAroundEyesLoader), findsOneWidget);
      expect(find.text('Your Bag is Looking Empty'), findsOneWidget);
      expect(find.text('EXPLORE THE COLLECTION'), findsOneWidget);
    });
  });
}
