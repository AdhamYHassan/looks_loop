import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/auth/auth_status_cubit.dart';
import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/app_snack_bar.dart';
import 'package:looks_loop/features/auth/presentation/bloc/login_cubit.dart';
import 'package:looks_loop/features/auth/presentation/bloc/login_state.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_form.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_hero.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_sheet.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';

/// Complete editorial Login screen wired to LoginCubit for authentication.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _onLoginStateChanged(BuildContext context, LoginState state) {
    switch (state) {
      case LoginError(:final message):
        AppSnackBar.showError(context, message: message);
      case LoginSuccess(:final authResponse):
        final name = authResponse.user.name.isNotEmpty
            ? authResponse.user.name
            : 'LookLoops';
        getIt<AuthStatusCubit>().setAuthenticated(
          UserProfileEntity(
            name: name,
            isGuest: false,
            email: authResponse.user.email,
            phone: authResponse.user.phone,
          ),
        );
        AppSnackBar.showSuccess(context, message: 'Welcome back, $name!');
        if (context.canPop()) {
          context.pop();
        } else {
          context.go(Routes.main);
        }
      case LoginInitial() || LoginLoading():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: ColorManager.olive,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: _onLoginStateChanged,
          builder: (context, state) {
            final isLoading = state is LoginLoading;

            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const LoginHero(),
                      Expanded(
                        child: LoginSheet(
                          child: Column(
                            children: [
                              LoginForm(
                                isLoading: isLoading,
                                onSubmit: (phone, password) {
                                  context.read<LoginCubit>().login(
                                    phone: phone,
                                    password: password,
                                  );
                                },
                                onCreateAccount: () =>
                                    context.push(Routes.register),
                              ),
                              // const Spacer(),
                              // SizedBox(height: 24.h),
                              // const LoginTermsNotice(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
