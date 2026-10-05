import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

class ChasingLoopLoader extends StatefulWidget {
  final double size;
  final Color? color;

  const ChasingLoopLoader({
    super.key,
    this.size = 64.0,
    this.color,
  });

  @override
  State<ChasingLoopLoader> createState() => _ChasingLoopLoaderState();
}

class _ChasingLoopLoaderState extends State<ChasingLoopLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
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

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _ChasingLoopPainter(
              progress: _controller.value,
              color: effectiveColor,
            ),
          );
        },
      ),
    );
  }
}

class _ChasingLoopPainter extends CustomPainter {
  final double progress;
  final Color color;

  _ChasingLoopPainter({
    required this.progress,
    required this.color,
  });

  // Calculate piecewise offset and opacity matching CSS cubic-bezier(.65, 0, .35, 1)
  ({Offset offset, double opacity}) _evalPiece(double delay) {
    final t = (progress - delay + 1.0) % 1.0;
    if (t < 0.30) {
      final curve = Curves.easeInOutCubic.transform(t / 0.30);
      return (offset: Offset(0, -70 * curve), opacity: 1.0 - 0.65 * curve);
    } else if (t < 0.60) {
      final curve = Curves.easeInOutCubic.transform((t - 0.30) / 0.30);
      return (offset: Offset(0, -70 * (1.0 - curve)), opacity: 0.35 + 0.65 * curve);
    }
    return (offset: Offset.zero, opacity: 1.0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Original SVG viewBox: -80, -80, 730, 800
    final scale = size.width / 730.0;
    canvas.save();
    canvas.scale(scale);
    canvas.translate(80, 80);

    final paintA = Paint()..color = color;

    // Piece A: slides up (0, -70)
    final a = _evalPiece(0.0);
    canvas.save();
    canvas.translate(a.offset.dx, a.offset.dy);
    paintA.color = color.withValues(alpha: a.opacity);
    canvas.drawPath(
      Path()
        ..moveTo(0, 0)..lineTo(126, 0)..lineTo(126, 521)
        ..cubicTo(56, 521, 0, 465, 0, 395)..close(),
      paintA,
    );
    canvas.restore();

    // Piece B: slides right (70, 0)
    final b = _evalPiece(0.15);
    canvas.save();
    canvas.translate(-b.offset.dy, b.offset.dx); // rotate translation 90deg
    paintA.color = color.withValues(alpha: b.opacity);
    canvas.drawPath(
      Path()
        ..moveTo(201, 0)..lineTo(405, 0)
        ..arcToPoint(const Offset(487, 82), radius: const Radius.circular(82))
        ..lineTo(201, 82)..close(),
      paintA,
    );
    canvas.restore();

    // Piece C: slides down (0, 70)
    final c = _evalPiece(0.30);
    canvas.save();
    canvas.translate(c.offset.dx, -c.offset.dy);
    paintA.color = color.withValues(alpha: c.opacity);
    canvas.drawPath(
      Path()
        ..moveTo(485, 82)
        ..cubicTo(535, 82, 569, 115, 569, 165)
        ..lineTo(569, 641)..lineTo(485, 641)..close(),
      paintA,
    );
    canvas.restore();

    // Piece D: slides left (-70, 0)
    final d = _evalPiece(0.45);
    canvas.save();
    canvas.translate(d.offset.dy, d.offset.dx);
    paintA.color = color.withValues(alpha: d.opacity);
    canvas.drawPath(
      Path()
        ..moveTo(126, 519)..lineTo(411, 519)..lineTo(411, 641)..lineTo(247, 641)
        ..cubicTo(180, 641, 126, 587, 126, 519)..close(),
      paintA,
    );
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ChasingLoopPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
