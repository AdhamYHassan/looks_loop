import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:looks_loop/core/network/network_result.dart';
import 'package:looks_loop/core/widgets/loaders/chasing_loop_loader.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_tokens_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_user_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/register_params.dart';
import 'package:looks_loop/features/auth/domain/repositories/auth_repository.dart';
import 'package:looks_loop/features/auth/domain/usecases/register_usecase.dart';
import 'package:looks_loop/features/auth/presentation/bloc/register_cubit.dart';
import 'package:looks_loop/features/auth/presentation/screens/register_screen.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_hero.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_submit_button.dart';
import 'package:looks_loop/features/auth/presentation/widgets/password_requirements_view.dart';
import 'package:looks_loop/features/auth/presentation/widgets/register_form.dart';
import 'package:looks_loop/features/auth/presentation/widgets/register_gender_selector.dart';
import 'package:looks_loop/features/auth/presentation/widgets/register_header_title.dart';
import 'package:looks_loop/features/auth/presentation/widgets/register_labeled_field.dart';

class FakeAuthRepoForScreenTest implements AuthRepository {
  @override
  Future<ApiResult<AuthResponseEntity>> login({
    required String phone,
    required String password,
    String? cartToken,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<AuthResponseEntity>> register(RegisterParams params) async {
    return const ApiSuccess(
      AuthResponseEntity(
        user: AuthUserEntity(
          id: 7,
          phone: '+201001234567',
          phoneLocal: '01001234567',
          name: 'Ahmed Medhat',
          email: 'ahmed@test.com',
          preferredLanguage: 'en',
        ),
        tokens: AuthTokensEntity(
          access: 'dummy_access',
          refresh: 'dummy_refresh',
        ),
      ),
    );
  }

  @override
  Future<ApiResult<void>> logout() async => const ApiSuccess(null);
}

void main() {
  Widget buildTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        home: BlocProvider(
          create: (_) => RegisterCubit(
            RegisterUseCase(FakeAuthRepoForScreenTest()),
          ),
          child: child,
        ),
      ),
    );
  }

  group('RegisterScreen & Form Widget Tests', () {
    testWidgets('renders hero, header, fields, gender selector, and continue button',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const RegisterScreen()),
      );
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(LoginHero), findsOneWidget);
      expect(find.byType(ChasingLoopLoader), findsWidgets);
      expect(find.byType(RegisterForm), findsOneWidget);
      expect(find.byType(RegisterHeaderTitle), findsOneWidget);
      expect(find.byType(RegisterLabeledField), findsNWidgets(7));
      expect(find.byType(PasswordRequirementsView), findsOneWidget);
      expect(find.byType(RegisterGenderSelector), findsOneWidget);
      expect(find.byType(LoginSubmitButton), findsOneWidget);
    });

    testWidgets('submits form with entered registration fields',
        (tester) async {
      RegisterParams? submittedParams;

      await tester.pumpWidget(
        buildTestableWidget(
          Scaffold(
            body: SingleChildScrollView(
              child: RegisterForm(
                onRegister: (params) {
                  submittedParams = params;
                },
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));

      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.at(0), 'Ahmed');
      await tester.enterText(textFields.at(1), 'Medhat');
      await tester.enterText(textFields.at(2), '01001234567');
      await tester.enterText(textFields.at(3), 'Zk9#mP82xL');
      await tester.enterText(textFields.at(4), 'Zk9#mP82xL');
      await tester.enterText(textFields.at(5), 'ahmed@example.com');

      final maleOption = find.text('auth.male');
      await tester.ensureVisible(maleOption);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(maleOption);
      await tester.pump(const Duration(milliseconds: 100));

      final submitBtn = find.byType(LoginSubmitButton);
      await tester.ensureVisible(submitBtn);
      await tester.pump(const Duration(milliseconds: 200));
      await tester.tap(submitBtn);
      await tester.pump(const Duration(milliseconds: 200));

      expect(submittedParams, isNotNull);
      expect(submittedParams!.name, equals('Ahmed Medhat'));
      expect(submittedParams!.phone, equals('01001234567'));
      expect(submittedParams!.password, equals('Zk9#mP82xL'));
      expect(submittedParams!.email, equals('ahmed@example.com'));
      expect(submittedParams!.gender, equals('male'));
    });
  });
}
