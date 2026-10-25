import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/checkout/domain/entities/checkout_step.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_progress_bar.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_sub_nav_bar.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';

class CheckoutHeader extends StatelessWidget {
  final CheckoutStep currentStep;
  final VoidCallback onBack;

  const CheckoutHeader({
    super.key,
    required this.currentStep,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AnnouncementBar(
          text: 'DISCOVER LOCAL & INTERNATIONAL BRANDS',
        ),
        CheckoutSubNavBar(onBack: onBack),
        CheckoutProgressBar(currentStep: currentStep),
        const Divider(height: 1, color: ColorManager.line),
      ],
    );
  }
}
