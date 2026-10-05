import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/widgets/loaders/loaders.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        home: Scaffold(
          body: Center(child: child),
        ),
      ),
    );
  }

  group('Brand Loaders Smoke Tests', () {
    testWidgets('ChasingLoopLoader renders and animates without error', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const ChasingLoopLoader(size: 80)));
      expect(find.byType(ChasingLoopLoader), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('LookAroundEyesLoader renders and animates without error', (tester) async {
      await tester.pumpWidget(buildTestableWidget(const LookAroundEyesLoader(width: 140)));
      expect(find.byType(LookAroundEyesLoader), findsOneWidget);

      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 2));
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('LookLoopsSkeleton renders cards and lines with shimmer without error', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const Column(
            children: [
              LookLoopsSkeleton.card(height: 120),
              SizedBox(height: 12),
              LookLoopsSkeleton.line(height: 16),
            ],
          ),
        ),
      );

      expect(find.byType(LookLoopsSkeleton), findsNWidgets(2));
      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
    });
  });
}
