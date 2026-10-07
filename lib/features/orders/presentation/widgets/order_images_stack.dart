import 'package:flutter/material.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';

/// Overlapping circular product thumbnails with a `+N` overflow bubble.
class OrderImagesStack extends StatelessWidget {
  final List<String> images;
  final int itemCount;
  final double size;

  const OrderImagesStack({
    super.key,
    required this.images,
    required this.itemCount,
    this.size = 44,
  });

  static const int _maxVisible = 3;

  @override
  Widget build(BuildContext context) {
    final visible = images.take(_maxVisible).toList();
    final hidden = itemCount - visible.length;
    final overlap = size * 0.62;
    final slots = visible.length + (hidden > 0 ? 1 : 0);
    final width = slots == 0 ? size : size + (slots - 1) * overlap;

    return SizedBox(
      width: width,
      height: size,
      child: Stack(
        children: [
          for (var i = 0; i < visible.length; i++)
            PositionedDirectional(
              start: i * overlap,
              child: _Bubble(
                size: size,
                child: AppCachedImage(
                  imageUrl: visible[i],
                  width: size,
                  height: size,
                  memCacheWidth: 120,
                ),
              ),
            ),
          if (hidden > 0)
            PositionedDirectional(
              start: visible.length * overlap,
              child: _Bubble(
                size: size,
                child: Container(
                  color: ColorManager.olive,
                  alignment: Alignment.center,
                  child: Text(
                    '+$hidden',
                    style: TextStyles.font11SemiBold(context)
                        .copyWith(color: ColorManager.cream),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final double size;
  final Widget child;

  const _Bubble({required this.size, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ColorManager.getCard(context), width: 2),
      ),
      child: ClipOval(child: child),
    );
  }
}
