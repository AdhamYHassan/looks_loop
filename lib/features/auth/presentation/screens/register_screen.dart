import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/app_snack_bar.dart';
import 'package:looks_loop/features/auth/presentation/bloc/register_cubit.dart';
import 'package:looks_loop/features/auth/presentation/bloc/register_state.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_hero.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_sheet.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_terms_notice.dart';
import 'package:looks_loop/features/auth/presentation/widgets/register_form.dart';

/// Complete profile / registration screen connected to RegisterCubit.
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  void _onRegisterStateChanged(BuildContext context, RegisterState state) {
    switch (state) {
      case RegisterError(:final message):
        AppSnackBar.showError(context, message: message);
      case RegisterSuccess(:final authResponse):
        final name = authResponse.user.name.isNotEmpty
            ? authResponse.user.name
            : 'LookLoops';
        AppSnackBar.showSuccess(
          context,
          message: 'Welcome to LookLoops, $name!',
        );
        context.go(Routes.main);
      case RegisterInitial() || RegisterLoading():
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
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: _onRegisterStateChanged,
          builder: (context, state) {
            final isLoading = state is RegisterLoading;

            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              const LoginHero(),
                              Builder(
                                builder: (innerContext) {
                                  final canPop =
                                      Navigator.maybeOf(innerContext)
                                              ?.canPop() ??
                                          false;
                                  if (!canPop) return const SizedBox.shrink();
                                  return PositionedDirectional(
                                    top: 8.h,
                                    end: 16.w,
                                    child: SafeArea(
                                      bottom: false,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.close_rounded,
                                          color: ColorManager.cream,
                                        ),
                                        onPressed: () =>
                                            Navigator.of(innerContext).pop(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Expanded(
                            child: LoginSheet(
                              child: Column(
                                children: [
                                  RegisterForm(
                                    isLoading: isLoading,
                                    onRegister: (params) {
                                      context
                                          .read<RegisterCubit>()
                                          .register(params);
                                    },
                                  ),
                                  const Spacer(),
                                  SizedBox(height: 24.h),
                                  const LoginTermsNotice(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
