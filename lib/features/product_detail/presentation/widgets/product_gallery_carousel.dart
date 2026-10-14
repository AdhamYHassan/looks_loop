import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';

class ProductGalleryCarousel extends StatefulWidget {
  final List<String> images;
  final int selectedIndex;
  final ValueChanged<int> onPageChanged;

  const ProductGalleryCarousel({
    super.key,
    required this.images,
    required this.selectedIndex,
    required this.onPageChanged,
  });

  @override
  State<ProductGalleryCarousel> createState() => _ProductGalleryCarouselState();
}

class _ProductGalleryCarouselState extends State<ProductGalleryCarousel> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.selectedIndex);
  }

  @override
  void didUpdateWidget(covariant ProductGalleryCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex &&
        _pageController.hasClients &&
        _pageController.page?.round() != widget.selectedIndex) {
      _pageController.animateToPage(
        widget.selectedIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.images.length;
    return Stack(
      children: [
        SizedBox(
          height: 480.h,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: total,
            onPageChanged: widget.onPageChanged,
            itemBuilder: (context, index) {
              return AppCachedImage(
                imageUrl: widget.images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: 480.h,
              );
            },
          ),
        ),
        Positioned(
          bottom: 16.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(total, (index) {
              final isActive = index == widget.selectedIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                width: isActive ? 20.w : 6.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: isActive
                      ? ColorManager.cream
                      : ColorManager.cream.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              );
            }),
          ),
        ),
        Positioned(
          bottom: 14.h,
          right: 16.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '${widget.selectedIndex + 1} / $total',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
