import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

/// Cycling typographic tagline that smoothly crossfades between
/// editorial brand taglines.
class LoginAnimatedTagline extends StatefulWidget {
  const LoginAnimatedTagline({super.key});

  @override
  State<LoginAnimatedTagline> createState() => _LoginAnimatedTaglineState();
}

class _LoginAnimatedTaglineState extends State<LoginAnimatedTagline> {
  static const List<String> _taglines = [
    'DISCOVER LOCAL & INTERNATIONAL BRANDS',
    'THE EDIT • FASHION IN MOTION',
  ];

  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 3500), (_) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _taglines.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.25),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Text(
        _taglines[_currentIndex],
        key: ValueKey<int>(_currentIndex),
        style: TextStyle(
          color: ColorManager.cream.withValues(alpha: 0.72),
          fontSize: 10.5.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 2.2.sp,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}
