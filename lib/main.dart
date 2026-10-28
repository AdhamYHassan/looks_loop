import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/helpers/firebase_helper.dart';
import 'package:looks_loop/core/routing/app_router.dart';
import 'package:looks_loop/core/theming/app_theme.dart';
import 'package:looks_loop/core/theming/theme_cubit.dart';
import 'package:looks_loop/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initAppDependencies();
  await FireBaseApi().initNotifications();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ThemeCubit>(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double tabletScaleFactor = 1.5;
          final bool isTablet = constraints.maxWidth >= 600;
          final Size designSize = isTablet
              ? Size(
                  constraints.maxWidth / tabletScaleFactor,
                  constraints.maxHeight / tabletScaleFactor,
                )
              : const Size(375, 812);

          return ScreenUtilInit(
            designSize: designSize,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    title: 'Look Loops',
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: themeMode,
                    routerConfig: AppRouter.router,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
