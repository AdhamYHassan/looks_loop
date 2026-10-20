import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class AnnouncementBar extends StatefulWidget {
  final List<String> announcements;
  final String? text;

  const AnnouncementBar({
    super.key,
    this.announcements = const [],
    this.text,
  });

  @override
  State<AnnouncementBar> createState() => _AnnouncementBarState();
}

class _AnnouncementBarState extends State<AnnouncementBar> {
  Timer? _timer;
  int _currentIndex = 0;

  List<String> get _items {
    if (widget.announcements.isNotEmpty) return widget.announcements;
    if (widget.text != null && widget.text!.isNotEmpty) return [widget.text!];
    return ['home.default_announcement'.tr()];
  }

  @override
  void initState() {
    super.initState();
    _startTimerIfNeeded();
  }

  @override
  void didUpdateWidget(covariant AnnouncementBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.announcements != widget.announcements) {
      if (_currentIndex >= _items.length) {
        _currentIndex = 0;
      }
      _startTimerIfNeeded();
    }
  }

  void _startTimerIfNeeded() {
    _timer?.cancel();
    if (_items.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 4), (_) {
        if (!mounted) return;
        setState(() {
          _currentIndex = (_currentIndex + 1) % _items.length;
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;
    final currentText = items.isNotEmpty ? items[_currentIndex % items.length] : '';

    return Container(
      height: 32.h,
      width: double.infinity,
      color: ColorManager.olive,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      alignment: Alignment.center,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.3),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: Text(
          currentText,
          key: ValueKey<String>(currentText),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.font8Announcement,
        ),
      ),
    );
  }
}

