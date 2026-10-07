import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/loaders/look_loops_skeleton.dart';

class OrdersSkeletonLoader extends StatelessWidget {
  const OrdersSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (_, _) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorManager.getCard(context),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorManager.getBorder(context)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                LookLoopsSkeleton(
                  height: 16,
                  width: 140,
                  borderRadius: BorderRadius.circular(4),
                ),
                const Spacer(),
                LookLoopsSkeleton(
                  height: 22,
                  width: 74,
                  borderRadius: BorderRadius.circular(20),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LookLoopsSkeleton(
              height: 12,
              width: 90,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                LookLoopsSkeleton(
                  height: 44,
                  width: 100,
                  borderRadius: BorderRadius.circular(22),
                ),
                const Spacer(),
                LookLoopsSkeleton(
                  height: 28,
                  width: 80,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
