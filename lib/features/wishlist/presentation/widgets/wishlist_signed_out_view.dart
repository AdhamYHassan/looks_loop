import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/loaders/chasing_loop_loader.dart';
import 'package:looks_loop/features/wishlist/presentation/widgets/wishlist_sign_in_button.dart';
import 'package:looks_loop/features/wishlist/presentation/widgets/wishlist_signed_out_chip.dart';
import 'package:looks_loop/features/wishlist/presentation/widgets/wishlist_signed_out_illustration.dart';

class WishlistSignedOutView extends StatefulWidget {
  final String message;
  final Future<void> Function() onRetry;

  const WishlistSignedOutView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  State<WishlistSignedOutView> createState() => _WishlistSignedOutViewState();
}

class _WishlistSignedOutViewState extends State<WishlistSignedOutView>
    with SingleTickerProviderStateMixin {
  bool _isRetrying = false;
  late final AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  Future<void> _handleRetry() async {
    if (_isRetrying) return;
    setState(() => _isRetrying = true);
    await widget.onRetry();
    if (mounted) {
      _shakeController.forward(from: 0.0);
      setState(() => _isRetrying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 24.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WishlistSignedOutIllustration(isRetrying: _isRetrying),
              Gap(28.h),
          Text(
            "You're signed out",
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.26,
              color: ColorManager.ink,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          Gap(8.h),
          SizedBox(
            width: 270.w,
            child: Text(
              "We couldn't verify your session. Sign in again to pick up where you left off.",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF7A8068),
                height: 1.45,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Gap(22.h),
          const WishlistSignInButton(),
          Gap(12.h),
          _buildRetryButton(),
          Gap(24.h),
          WishlistSignedOutChip(
            message: widget.message,
            shakeController: _shakeController,
          ),
        ],
      ),
    ),
  ),
);
}

  Widget _buildRetryButton() {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.olive,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      ),
      onPressed: _handleRetry,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _isRetrying ? 'Retrying' : 'Retry',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: ColorManager.olive,
            ),
          ),
          if (_isRetrying) ...[
            Gap(8.w),
            ChasingLoopLoader(size: 16.w, color: ColorManager.olive),
          ],
        ],
      ),
    );
  }
}
