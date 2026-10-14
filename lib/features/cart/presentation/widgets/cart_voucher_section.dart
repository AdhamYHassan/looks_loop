import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';

class CartVoucherSection extends StatefulWidget {
  final String? appliedCode;
  final ValueChanged<String> onApplyPromo;
  final VoidCallback? onRemovePromo;
  final String? errorMessage;
  final bool isLoading;

  const CartVoucherSection({
    super.key,
    this.appliedCode,
    required this.onApplyPromo,
    this.onRemovePromo,
    this.errorMessage,
    this.isLoading = false,
  });

  @override
  State<CartVoucherSection> createState() => _CartVoucherSectionState();
}

class _CartVoucherSectionState extends State<CartVoucherSection> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.appliedCode ?? '');
  }

  @override
  void didUpdateWidget(covariant CartVoucherSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.appliedCode != oldWidget.appliedCode) {
      _controller.text = widget.appliedCode ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isApplied =>
      widget.appliedCode != null && widget.appliedCode!.isNotEmpty;

  void _handleSubmit() {
    if (_isApplied) {
      widget.onRemovePromo?.call();
      _controller.clear();
    } else {
      final code = _controller.text.trim();
      if (code.isNotEmpty) widget.onApplyPromo(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: ColorManager.getSurface(context),
        border: Border(
          bottom: BorderSide(color: ColorManager.getBorder(context), width: 1.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 44.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.getBorder(context), width: 1.w),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: TextField(
                    controller: _controller,
                    readOnly: _isApplied,
                    style: TextStyles.font13Medium(context),
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      hintText: 'Enter promo code',
                      hintStyle: TextStyles.font13MutedMedium(context),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    ),
                    onSubmitted: (_) => _handleSubmit(),
                  ),
                ),
              ),
              Gap(10.w),
              SizedBox(
                height: 44.h,
                child: ElevatedButton(
                  onPressed: widget.isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isApplied ? ColorManager.orange : ColorManager.olive,
                    foregroundColor: ColorManager.cream,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                  ),
                  child: widget.isLoading
                      ? SizedBox(
                          width: 16.w,
                          height: 16.h,
                          child: CircularProgressIndicator(strokeWidth: 2.w, color: ColorManager.cream),
                        )
                      : Text(
                          _isApplied ? 'REMOVE' : 'APPLY',
                          style: TextStyles.font11Action(context).copyWith(
                            color: ColorManager.cream,
                            letterSpacing: 1.2,
                          ),
                        ),
                ),
              ),
            ],
          ),
          if (widget.errorMessage != null && widget.errorMessage!.isNotEmpty) ...[
            Gap(8.h),
            Text(
              widget.errorMessage!,
              style: TextStyle(
                color: ColorManager.orange,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
