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
import 'package:looks_loop/features/auth/domain/usecases/login_usecase.dart';
import 'package:looks_loop/features/auth/presentation/bloc/login_cubit.dart';
import 'package:looks_loop/features/auth/presentation/screens/login_screen.dart';
import 'package:looks_loop/features/auth/presentation/widgets/animated_arrow_icon.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_form.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_hero.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_input_field.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_submit_button.dart';

class FakeAuthRepo implements AuthRepository {
  @override
  Future<ApiResult<AuthResponseEntity>> login({
    required String phone,
    required String password,
    String? cartToken,
  }) async {
    return const ApiSuccess(
      AuthResponseEntity(
        user: AuthUserEntity(
          id: 1,
          phone: '01007951864',
          phoneLocal: '01007951864',
          name: 'Adham',
          email: 'adham@gmail.com',
          preferredLanguage: 'en',
        ),
        tokens: AuthTokensEntity(access: 'token', refresh: 'refresh'),
      ),
    );
  }

  @override
  Future<ApiResult<AuthResponseEntity>> register(RegisterParams params) async {
    return const ApiSuccess(
      AuthResponseEntity(
        user: AuthUserEntity(
          id: 1,
          phone: '01007951864',
          phoneLocal: '01007951864',
          name: 'Adham',
          email: 'adham@gmail.com',
          preferredLanguage: 'en',
        ),
        tokens: AuthTokensEntity(access: 'token', refresh: 'refresh'),
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
          create: (_) => LoginCubit(LoginUseCase(FakeAuthRepo())),
          child: child,
        ),
      ),
    );
  }

  group('LoginScreen Smoke & Interaction Tests', () {
    testWidgets('renders hero, chasing loader, form and buttons without error', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(const LoginScreen()),
      );
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(LoginHero), findsOneWidget);
      expect(find.byType(ChasingLoopLoader), findsWidgets);
      expect(find.byType(LoginForm), findsOneWidget);
      expect(find.byType(LoginInputField), findsNWidgets(2));
      expect(find.byType(LoginSubmitButton), findsOneWidget);
      expect(find.byType(AnimatedArrowIcon), findsOneWidget);
    });

    testWidgets('submitting form triggers onSubmit with entered values', (tester) async {
      String? submittedPhone;
      String? submittedPassword;

      await tester.pumpWidget(
        buildTestableWidget(
          Scaffold(
            body: LoginForm(
              onSubmit: (phone, password) {
                submittedPhone = phone;
                submittedPassword = password;
              },
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));

      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.at(0), '01007951864');
      await tester.enterText(textFields.at(1), 'SecretPass123');
      await tester.pump(const Duration(milliseconds: 100));

      final submitBtn = find.byType(LoginSubmitButton);
      await tester.tap(submitBtn);
      await tester.pump(const Duration(milliseconds: 200));

      expect(submittedPhone, equals('01007951864'));
      expect(submittedPassword, equals('SecretPass123'));
    });
  });
}
