import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/features/auth/presentation/widgets/lookloops_date_picker_sheet.dart';

void main() {
  Widget buildTestableWidget(Widget child, {TargetPlatform platform = TargetPlatform.iOS}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        theme: ThemeData(platform: platform),
        home: Scaffold(body: child),
      ),
    );
  }

  group('LookLoopsDatePickerSheet Widget Tests', () {
    testWidgets('renders action buttons and CupertinoDatePicker on iOS',
        (tester) async {
      tester.view.physicalSize = const Size(375 * 3, 812 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      await tester.pumpWidget(
        buildTestableWidget(
          LookLoopsDatePickerSheet(
            initialDate: DateTime(2000, 1, 1),
            minimumDate: DateTime(1920),
            maximumDate: DateTime(2026),
            onDateSelected: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CupertinoDatePicker), findsOneWidget);
      expect(find.text('common.cancel'), findsOneWidget);
      expect(find.text('common.done'), findsOneWidget);
      expect(find.text('auth.date_of_birth'), findsOneWidget);
    });

    testWidgets('calls onDateSelected when done button is tapped on iOS',
        (tester) async {
      tester.view.physicalSize = const Size(375 * 3, 812 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      DateTime? selected;
      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                selected = await LookLoopsDatePickerSheet.show(
                  context: context,
                  initialDate: DateTime(2000, 5, 15),
                );
              },
              child: const Text('Open Picker'),
            ),
          ),
          platform: TargetPlatform.iOS,
        ),
      );
      await tester.pumpAndSettle();

      // Open sheet
      await tester.tap(find.text('Open Picker'));
      await tester.pumpAndSettle();

      expect(find.byType(LookLoopsDatePickerSheet), findsOneWidget);

      // Tap Done
      await tester.tap(find.text('common.done'));
      await tester.pumpAndSettle();

      expect(selected, equals(DateTime(2000, 5, 15)));
    });

    testWidgets('opens Material DatePickerDialog on Android',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                await LookLoopsDatePickerSheet.show(
                  context: context,
                  initialDate: DateTime(2000, 5, 15),
                );
              },
              child: const Text('Open Picker'),
            ),
          ),
          platform: TargetPlatform.android,
        ),
      );
      await tester.pumpAndSettle();

      // Open Android Dialog
      await tester.tap(find.text('Open Picker'));
      await tester.pumpAndSettle();

      expect(find.byType(DatePickerDialog), findsOneWidget);
    });
  });
}
