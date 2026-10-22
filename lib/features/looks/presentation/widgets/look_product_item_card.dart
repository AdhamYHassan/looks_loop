import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_cached_image.dart';
import 'package:looks_loop/features/home/domain/entities/product_entities.dart';
import 'package:looks_loop/features/looks/presentation/widgets/look_product_actions.dart';
import 'package:looks_loop/features/looks/presentation/widgets/look_product_variants.dart';

class LookProductItemCard extends StatefulWidget {
  final ProductEntity product;
  final VoidCallback onViewProduct;
  final void Function({int? colorId, String? size}) onAddToBag;

  final bool isAddingToBag;

  const LookProductItemCard({
    super.key,
    required this.product,
    required this.onViewProduct,
    required this.onAddToBag,
    this.isAddingToBag = false,
  });

  @override
  State<LookProductItemCard> createState() => _LookProductItemCardState();
}

class _LookProductItemCardState extends State<LookProductItemCard> {
  int? _selectedColorId;
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    _selectedColorId = widget.product.colors.firstOrNull?.id;
    final isShoe = widget.product.subcategory.toLowerCase().contains('shoe') ||
        widget.product.category.toLowerCase().contains('shoe');
    _selectedSize = isShoe ? '38' : 'M';
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: SizedBox(
                width: 110.w,
                height: 145.h,
                child: AppCachedImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  memCacheWidth: 350,
                  memCacheHeight: 450,
                ),
              ),
            ),
            Gap(14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand.toUpperCase(),
                    style: TextStyles.font11Eyebrow(context).copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 11.sp,
                      letterSpacing: 0.8,
                    ),
                  ),
                  Gap(3.h),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font13TextBold(context).copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(5.h),
                  LookProductPriceRow(product: product),
                  if (product.colors.isNotEmpty) ...[
                    Gap(8.h),
                    LookProductColorSwatches(
                      colors: product.colors,
                      selectedColorId: _selectedColorId,
                      onColorSelected: (id) =>
                          setState(() => _selectedColorId = id),
                    ),
                  ],
                  Gap(8.h),
                  LookProductSizesRow(
                    category: product.category,
                    subcategory: product.subcategory,
                    selectedSize: _selectedSize,
                    onSizeSelected: (size) =>
                        setState(() => _selectedSize = size),
                  ),
                  Gap(12.h),
                  LookProductActionButtons(
                    onAddToBag: () => widget.onAddToBag(
                      colorId: _selectedColorId,
                      size: _selectedSize,
                    ),
                    onViewProduct: widget.onViewProduct,
                    isAddingToBag: widget.isAddingToBag,
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Divider(
            height: 1,
            color: ColorManager.getBorder(context),
          ),
        ),
      ],
    );
  }
}
