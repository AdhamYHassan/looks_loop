import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

class TypographicMaskWipe extends StatelessWidget {
  final Animation<double> wipeProgress;
  final Animation<double> edgeGlowOpacity;

  const TypographicMaskWipe({
    super.key,
    required this.wipeProgress,
    required this.edgeGlowOpacity,
  });

  @override
  Widget build(BuildContext context) {
    final logoWidth = 210.w;
    final logoHeight = 44.h;

    return AnimatedBuilder(
      animation: wipeProgress,
      builder: (context, child) {
        final progress = wipeProgress.value.clamp(0.0, 1.0);

        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Clipped Logo (wipes smoothly from left to right)
            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Image.asset(
                  'assets/images/app_logo.png',
                  width: logoWidth,
                  height: logoHeight,
                  fit: BoxFit.contain,
                  color: ColorManager.cream,
                ),
              ),
            ),

            // High-Fashion Leading Edge Wipe Hairline
            if (progress > 0.0 && progress < 1.0)
              Positioned(
                left: (logoWidth * progress) - 1.w,
                top: 0,
                bottom: 0,
                child: FadeTransition(
                  opacity: edgeGlowOpacity,
                  child: Container(
                    width: 2.w,
                    height: logoHeight,
                    decoration: BoxDecoration(
                      color: ColorManager.cream,
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.cream.withValues(alpha: 0.8),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
