import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Fades and slides [child] up in sequence, driven by a shared [animation].
/// Each [index] starts slightly later than the previous one.
class StaggeredReveal extends StatelessWidget {
  final Animation<double> animation;
  final int index;
  final Widget child;

  const StaggeredReveal({
    super.key,
    required this.animation,
    required this.index,
    required this.child,
  });

  static const double _base = 0.2;
  static const double _step = 0.09;
  static const double _span = 0.35;

  @override
  Widget build(BuildContext context) {
    final start = (_base + index * _step).clamp(0.0, 0.7);
    final end = (start + _span).clamp(start, 1.0);
    final interval = Interval(start, end, curve: Curves.easeOutCubic);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final t = interval.transform(animation.value);
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, 18.h * (1 - t)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
