import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';
import 'package:looks_loop/features/more/presentation/widgets/more_content.dart';
import 'package:looks_loop/features/more/presentation/widgets/more_guest_card.dart';
import 'package:looks_loop/features/more/presentation/widgets/more_user_card.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }

  group('MoreUserCard & MoreContent Authentication Switch Tests', () {
    testWidgets('renders MoreGuestCard when profile.isGuest is true', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const MoreContent(
            profile: UserProfileEntity.guest(),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MoreGuestCard), findsOneWidget);
      expect(find.byType(MoreUserCard), findsNothing);
    });

    testWidgets('renders MoreUserCard with name and phone when user is logged in', (tester) async {
      const authProfile = UserProfileEntity(
        name: 'Ahmed Medhat',
        phone: '+20 100 123 4567',
        isGuest: false,
      );

      await tester.pumpWidget(
        buildTestableWidget(
          const MoreContent(
            profile: authProfile,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(MoreGuestCard), findsNothing);
      expect(find.byType(MoreUserCard), findsOneWidget);
      expect(find.text('Ahmed Medhat'), findsOneWidget);
      expect(find.text('+20 100 123 4567'), findsOneWidget);
    });
  });
}
