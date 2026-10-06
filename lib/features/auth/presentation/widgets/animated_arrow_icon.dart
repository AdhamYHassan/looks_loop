import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

/// Animated forward arrow that smoothly nudges horizontally to draw attention.
class AnimatedArrowIcon extends StatefulWidget {
  final Color? color;
  final double? size;

  const AnimatedArrowIcon({
    super.key,
    this.color,
    this.size,
  });

  @override
  State<AnimatedArrowIcon> createState() => _AnimatedArrowIconState();
}

class _AnimatedArrowIconState extends State<AnimatedArrowIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _nudgeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _nudgeAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.35, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return SlideTransition(
      position: _nudgeAnimation,
      child: Icon(
        isRtl ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded,
        size: widget.size ?? 20.sp,
        color: widget.color ?? ColorManager.cream,
      ),
    );
  }
}
