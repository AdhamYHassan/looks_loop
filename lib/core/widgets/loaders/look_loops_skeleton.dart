import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

class LookLoopsSkeleton extends StatefulWidget {
  final double height;
  final double? width;
  final BorderRadius? borderRadius;

  const LookLoopsSkeleton({
    super.key,
    required this.height,
    this.width,
    this.borderRadius,
  });

  /// Standard brand card skeleton with asymmetric corners (20, 20, 20, 6)
  const LookLoopsSkeleton.card({
    super.key,
    this.height = 120.0,
    this.width = double.infinity,
    this.borderRadius,
  });

  /// Text line skeleton
  const LookLoopsSkeleton.line({
    super.key,
    this.height = 16.0,
    this.width = double.infinity,
    this.borderRadius,
  });

  @override
  State<LookLoopsSkeleton> createState() => _LookLoopsSkeletonState();
}

class _LookLoopsSkeletonState extends State<LookLoopsSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ColorManager.isDark(context);
    final baseColor = isDark
        ? const Color(0xFF262C1F)
        : const Color(0xFFE2E6D8);
    final highlightColor = isDark
        ? const Color(0xFF3A4330)
        : const Color(0xFFFFFFFF);

    // Brand signature asymmetric corner radius from HTML: 20px 20px 20px 6px
    final defaultRadius = BorderRadius.only(
      topLeft: Radius.circular(20.r),
      topRight: Radius.circular(20.r),
      bottomRight: Radius.circular(20.r),
      bottomLeft: Radius.circular(6.r),
    );

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final progress = _controller.value;

          return Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius ?? defaultRadius,
              gradient: LinearGradient(
                begin: Alignment(-2.5 + (4.0 * progress), 0.0),
                end: Alignment(-0.5 + (4.0 * progress), 0.0),
                colors: [
                  baseColor,
                  highlightColor,
                  baseColor,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          );
        },
      ),
    );
  }
}
