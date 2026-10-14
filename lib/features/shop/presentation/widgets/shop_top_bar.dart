import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/home/presentation/widgets/home_top_bar.dart';

class ShopTopBar extends StatelessWidget {
  const ShopTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.olive,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AnnouncementBar(),
            HomeTopBar(onBagTap: () => context.push(Routes.cart)),
          ],
        ),
      ),
    );
  }
}
