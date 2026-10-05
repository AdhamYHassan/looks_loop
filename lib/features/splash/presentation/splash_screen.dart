import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
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

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    // 1. Horizontal Mask Wipe (15% -> 55%)
    _wipeProgress = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.12, 0.55, curve: Curves.easeInOutCubic),
    );

    // 2. Leading Edge Hairline Glow (0% -> 60%)
    _edgeGlowFade = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 70,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 15,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.08, 0.60),
      ),
    );

    // 3. Staggered Tagline Slide from behind Clip Mask (55% -> 75%)
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

    // 4. Smooth Cinematic Exit Dissolve (85% -> 100%)
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

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        context.go(Routes.main);
      }
    });

    _controller.forward();
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
                    // Staggered Mask Wipe Brand Logo
                    TypographicMaskWipe(
                      wipeProgress: _wipeProgress,
                      edgeGlowOpacity: _edgeGlowFade,
                    ),
                    SizedBox(height: 14.h),

                    // Staggered Editorial Tagline Behind Vertical Clip Mask
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
