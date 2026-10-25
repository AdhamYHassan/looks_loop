import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/checkout/domain/entities/delivery_method_entity.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_delivery_card.dart';

class CheckoutDeliveryStep extends StatefulWidget {
  final List<DeliveryMethodEntity> methods;
  final DeliveryMethodEntity? selectedMethod;
  final bool isLoading;
  final String? error;
  final ValueChanged<DeliveryMethodEntity> onSelectMethod;
  final VoidCallback? onRetry;

  const CheckoutDeliveryStep({
    super.key,
    required this.methods,
    required this.selectedMethod,
    this.isLoading = false,
    this.error,
    required this.onSelectMethod,
    this.onRetry,
  });

  @override
  State<CheckoutDeliveryStep> createState() => _CheckoutDeliveryStepState();
}

class _CheckoutDeliveryStepState extends State<CheckoutDeliveryStep> {
  @override
  void initState() {
    super.initState();
    _checkAndFetch();
  }

  @override
  void didUpdateWidget(covariant CheckoutDeliveryStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checkAndFetch();
  }

  void _checkAndFetch() {
    if (widget.methods.isEmpty && !widget.isLoading && widget.error == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted &&
            widget.methods.isEmpty &&
            !widget.isLoading &&
            widget.error == null) {
          widget.onRetry?.call();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DELIVERY METHOD',
            style: TextStyles.font20Bold(context).copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
          Gap(16.h),
          if (widget.isLoading ||
              (widget.methods.isEmpty && widget.error == null))
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: CircularProgressIndicator(color: ColorManager.olive),
              ),
            )
          else if (widget.error != null)
            Center(
              child: Column(
                children: [
                  Text(
                    widget.error!,
                    style: TextStyle(color: Colors.red, fontSize: 13.sp),
                  ),
                  Gap(12.h),
                  if (widget.onRetry != null)
                    ElevatedButton(
                      onPressed: widget.onRetry,
                      child: const Text('Retry'),
                    ),
                ],
              ),
            )
          else
            ...widget.methods.map(
              (method) => CheckoutDeliveryCard(
                key: ValueKey(method.code),
                method: method,
                isSelected: method.code == widget.selectedMethod?.code,
                onSelect: () => widget.onSelectMethod(method),
              ),
            ),
          Gap(100.h),
        ],
      ),
    );
  }
}
