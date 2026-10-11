import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/home/presentation/bloc/home_cubit.dart';
import 'package:looks_loop/features/splash/presentation/widgets/typographic_mask_wipe.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _wipeProgress;
  late final Animation<double> _edgeGlowFade;
  late final Animation<Offset> _taglineSlide;
  late final Animation<double> _taglineFade;
  late final Animation<double> _exitFade;
  late final Animation<double> _exitScale;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _bootstrapAndPrewarm();
  }

  void _initAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _wipeProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.12, 0.55, curve: Curves.easeInOutCubic),
    );

    _edgeGlowFade = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 15,
      ),
      TweenSequenceItem(tween: ConstantTween<double>(1.0), weight: 70),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 15,
      ),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.08, 0.60)),
    );

    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 1.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _taglineFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 0.72, curve: Curves.easeOut),
    );

    _exitFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.85, 1.0, curve: Curves.easeInCubic),
      ),
    );

    _exitScale = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.85, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  Future<void> _bootstrapAndPrewarm() async {
    _controller.forward();

    try {
      // -----------------------------------------------------------------------
      // Bootstrap Architecture Notes:
      // 1. `_checkVersion()`: The ONLY hard blocker / circuit breaker.
      //    If force update is required, halt flow and show un-dismissable update dialog.
      // 2. `_initAuthSession()`: Non-blocking. If login/refresh fails, gracefully
      //    falls back to guest mode without interrupting navigation.
      // 3. `_fetchRemoteConfig()`: Non-blocking. Uses default/cached flags on failure.
      // 4. `HomeCubit.fetchHomeFeed()`: Eagerly pre-warms feed concurrently.
      //
      // Future Parallel Pipeline:
      // final results = await Future.wait([
      //   _checkVersion(),        // Hard gatekeeper
      //   _initAuthSession(),     // Fallback to guest on error
      //   _fetchRemoteConfig(),   // Non-blocking
      //   getIt<HomeCubit>().fetchHomeFeed(),
      // ]);
      // -----------------------------------------------------------------------

      // Eagerly pre-warm Home Feed in the background during splash animation
      final homeCubit = getIt<HomeCubit>();
      final homeFetchFuture = homeCubit.fetchHomeFeed();

      // Race between: animation completion + home fetch vs hard timeout cap
      await Future.any([
        Future.wait([
          homeFetchFuture,
          Future.delayed(const Duration(milliseconds: 2400)),
        ]),
        Future.delayed(const Duration(milliseconds: 2800)),
      ]);
    } catch (_) {
      // Graceful degradation: navigate to main screen where Home handles error/retry
    } finally {
      if (mounted) {
        context.go(Routes.main);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ColorManager.ink,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: ColorManager.ink,
        body: Center(
          child: RepaintBoundary(
            child: FadeTransition(
              opacity: _exitFade,
              child: ScaleTransition(
                scale: _exitScale,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TypographicMaskWipe(
                      wipeProgress: _wipeProgress,
                      edgeGlowOpacity: _edgeGlowFade,
                    ),
                    SizedBox(height: 14.h),
                    ClipRect(
                      child: SlideTransition(
                        position: _taglineSlide,
                        child: FadeTransition(
                          opacity: _taglineFade,
                          child: Text(
                            'THE EDIT • FASHION IN MOTION',
                            style: TextStyle(
                              color: ColorManager.cream.withValues(alpha: 0.55),
                              fontSize: 9.5.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 4.sp,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
