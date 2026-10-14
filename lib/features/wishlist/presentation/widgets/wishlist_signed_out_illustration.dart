import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

class WishlistSignedOutIllustration extends StatefulWidget {
  final bool isRetrying;

  const WishlistSignedOutIllustration({super.key, this.isRetrying = false});

  @override
  State<WishlistSignedOutIllustration> createState() =>
      _WishlistSignedOutIllustrationState();
}

class _WishlistSignedOutIllustrationState
    extends State<WishlistSignedOutIllustration>
    with TickerProviderStateMixin {
  late final AnimationController _idleController;
  late final AnimationController _attemptController;

  @override
  void initState() {
    super.initState();
    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat();

    _attemptController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
  }

  @override
  void didUpdateWidget(covariant WishlistSignedOutIllustration oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRetrying && !oldWidget.isRetrying) {
      _attemptController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _idleController.dispose();
    _attemptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: Listenable.merge([_idleController, _attemptController]),
        builder: (context, _) {
          return CustomPaint(
            size: Size(170.w, 193.h),
            painter: _SignedOutLogoPainter(
              idleProgress: _idleController.value,
              attemptProgress: _attemptController.value,
              isRetrying: widget.isRetrying,
            ),
          );
        },
      ),
    );
  }
}

class _SignedOutLogoPainter extends CustomPainter {
  final double idleProgress;
  final double attemptProgress;
  final bool isRetrying;

  _SignedOutLogoPainter({
    required this.idleProgress,
    required this.attemptProgress,
    required this.isRetrying,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 570.0;
    canvas.save();
    canvas.scale(scale);

    final olivePaint = Paint()..color = ColorManager.olive;
    final slotPaint = Paint()
      ..color = ColorManager.olive.withValues(alpha: 0.14);
    const tintColor = Color(0xFF9AA386);

    // Ghost slot (Piece D outline at resting spot)
    canvas.drawPath(_pathD(), slotPaint);

    // Piece A with subtle sinusoidal bob
    final bobA = math.sin(idleProgress * 2 * math.pi) * 8.0;
    canvas.save();
    canvas.translate(0, bobA);
    canvas.drawPath(_pathA(), olivePaint);
    canvas.restore();

    // Piece B (offset phase)
    final bobB = math.sin((idleProgress - 0.33) * 2 * math.pi) * 8.0;
    canvas.save();
    canvas.translate(0, bobB);
    canvas.drawPath(_pathB(), olivePaint);
    canvas.restore();

    // Piece C (offset phase)
    final bobC = math.sin((idleProgress - 0.66) * 2 * math.pi) * 8.0;
    canvas.save();
    canvas.translate(0, bobC);
    canvas.drawPath(_pathC(), olivePaint);
    canvas.restore();

    // Piece D: Drifting detached piece or attempting reconnect
    _paintPieceD(canvas, tintColor);

    canvas.restore();
  }

  void _paintPieceD(Canvas canvas, Color tintColor) {
    double dx = -60.0;
    double dy = 80.0;
    double rot = -8.0 * (math.pi / 180.0);
    Color color = tintColor;

    if (attemptProgress > 0.0 && attemptProgress < 1.0) {
      final t = attemptProgress;
      final snapFactor = (t < 0.35)
          ? Curves.easeInOutCubic.transform(t / 0.35)
          : (t <= 0.65)
              ? 1.0
              : 1.0 - Curves.easeInOutCubic.transform((t - 0.65) / 0.35);
      dx = -60.0 * (1.0 - snapFactor);
      dy = 80.0 * (1.0 - snapFactor);
      rot = (-8.0 * (1.0 - snapFactor)) * (math.pi / 180.0);
      color = Color.lerp(tintColor, ColorManager.olive, snapFactor)!;
    } else {
      final float = math.sin(idleProgress * 2 * math.pi);
      dx += float * 6.0;
      dy -= float * 6.0;
    }

    canvas.save();
    // Pivot around center-bottom of piece D (approx 268, 580)
    canvas.translate(268 + dx, 580 + dy);
    canvas.rotate(rot);
    canvas.translate(-268, -580);
    canvas.drawPath(_pathD(), Paint()..color = color);
    canvas.restore();
  }

  Path _pathA() => Path()
    ..moveTo(0, 0)..lineTo(126, 0)..lineTo(126, 521)
    ..cubicTo(56, 521, 0, 465, 0, 395)..close();

  Path _pathB() => Path()
    ..moveTo(201, 0)..lineTo(405, 0)
    ..arcToPoint(const Offset(487, 82), radius: const Radius.circular(82))
    ..lineTo(201, 82)..close();

  Path _pathC() => Path()
    ..moveTo(485, 82)..cubicTo(535, 82, 569, 115, 569, 165)
    ..lineTo(569, 641)..lineTo(485, 641)..close();

  Path _pathD() => Path()
    ..moveTo(126, 519)..lineTo(411, 519)..lineTo(411, 641)..lineTo(247, 641)
    ..cubicTo(180, 641, 126, 587, 126, 519)..close();

  @override
  bool shouldRepaint(covariant _SignedOutLogoPainter oldDelegate) => true;
}
