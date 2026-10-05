import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/widgets/loaders/loaders.dart';
import 'package:looks_loop/features/home/presentation/widgets/chasing_loop_preview_dialog.dart';
import 'package:looks_loop/features/home/presentation/widgets/home_top_bar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }

  group('HomeTopBar and ChasingLoopPreviewDialog Tests', () {
    testWidgets('renders dummy loader icon when onLoaderTap is provided', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        buildTestableWidget(
          HomeTopBar(
            onLoaderTap: () => tapped = true,
          ),
        ),
      );

      final sparklesFinder = find.byIcon(LucideIcons.sparkles);
      expect(sparklesFinder, findsOneWidget);

      await tester.tap(sparklesFinder);
      expect(tapped, isTrue);
    });

    testWidgets('does not render dummy loader icon when onLoaderTap is null', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const HomeTopBar(),
        ),
      );

      expect(find.byIcon(LucideIcons.sparkles), findsNothing);
    });

    testWidgets('ChasingLoopPreviewDialog shows ChasingLoopLoader and closes on X', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => ChasingLoopPreviewDialog.show(context),
              child: const Text('Open'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(ChasingLoopPreviewDialog), findsOneWidget);
      expect(find.byType(ChasingLoopLoader), findsOneWidget);
      expect(find.text('Brand Loop Loader'), findsOneWidget);

      // Tap close button
      await tester.tap(find.byIcon(LucideIcons.x));
      await tester.pumpAndSettle();

      expect(find.byType(ChasingLoopPreviewDialog), findsNothing);
    });
  });
}
