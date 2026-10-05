import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

class LookAroundEyesLoader extends StatefulWidget {
  final double width;
  final Color? color;

  const LookAroundEyesLoader({
    super.key,
    this.width = 132.0,
    this.color,
  });

  @override
  State<LookAroundEyesLoader> createState() => _LookAroundEyesLoaderState();
}

class _LookAroundEyesLoaderState extends State<LookAroundEyesLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.color ?? ColorManager.olive;
    final height = widget.width / (330.0 / 200.0);

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            size: Size(widget.width, height),
            painter: _LookAroundEyesPainter(
              progress: _controller.value,
              color: effectiveColor,
            ),
          );
        },
      ),
    );
  }
}

class _LookAroundEyesPainter extends CustomPainter {
  final double progress;
  final Color color;

  _LookAroundEyesPainter({
    required this.progress,
    required this.color,
  });

  // Calculate pupil translation offset over 4s timeline
  Offset _evalPupilOffset() {
    final p = progress;
    if (p < 0.15) {
      return Offset.zero;
    } else if (p < 0.25) {
      final t = Curves.easeInOut.transform((p - 0.15) / 0.10);
      return Offset.lerp(Offset.zero, const Offset(-24, 0), t)!;
    } else if (p < 0.40) {
      return const Offset(-24, 0);
    } else if (p < 0.50) {
      final t = Curves.easeInOut.transform((p - 0.40) / 0.10);
      return Offset.lerp(const Offset(-24, 0), const Offset(24, -14), t)!;
    } else if (p < 0.65) {
      return const Offset(24, -14);
    } else if (p < 0.75) {
      final t = Curves.easeInOut.transform((p - 0.65) / 0.10);
      return Offset.lerp(const Offset(24, -14), Offset.zero, t)!;
    }
    return Offset.zero;
  }

  // Calculate eyelid blink scaleY around center y=100
  double _evalBlinkScale() {
    final p = progress;
    if (p >= 0.86 && p < 0.89) {
      final t = (p - 0.86) / 0.03;
      return 1.0 - 0.92 * t; // down to 0.08
    } else if (p >= 0.89 && p < 0.92) {
      final t = (p - 0.89) / 0.03;
      return 0.08 + 0.92 * t; // back to 1.0
    }
    return 1.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // SVG viewBox: 0 0 330 200
    final scale = size.width / 330.0;
    canvas.save();
    canvas.scale(scale);

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 26.0;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final pupilOffset = _evalPupilOffset();
    final blinkScale = _evalBlinkScale();

    void drawEye(double cx, double cy) {
      // Eyelid Ring (blinks vertically around eye center)
      canvas.save();
      canvas.translate(cx, cy);
      canvas.scale(1.0, blinkScale);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: 136, height: 164),
        strokePaint,
      );
      canvas.restore();

      // Pupil (looking around, clipped when blinking)
      canvas.save();
      canvas.translate(cx, cy);
      canvas.scale(1.0, blinkScale);
      canvas.drawOval(
        Rect.fromCenter(
          center: pupilOffset,
          width: 44,
          height: 60,
        ),
        fillPaint,
      );
      canvas.restore();
    }

    drawEye(90, 100);
    drawEye(240, 100);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _LookAroundEyesPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
