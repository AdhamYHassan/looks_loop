import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/routing/routes.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/product_detail/presentation/bloc/product_detail_cubit.dart';
import 'package:looks_loop/features/product_detail/presentation/bloc/product_detail_state.dart';
import 'package:looks_loop/features/product_detail/presentation/widgets/product_color_selector.dart';
import 'package:looks_loop/features/product_detail/presentation/widgets/product_description_section.dart';
import 'package:looks_loop/features/product_detail/presentation/widgets/product_expandable_sections.dart';
import 'package:looks_loop/features/product_detail/presentation/widgets/product_gallery_carousel.dart';
import 'package:looks_loop/features/product_detail/presentation/widgets/product_info_header.dart';
import 'package:looks_loop/features/product_detail/presentation/widgets/product_recommended_rail.dart';
import 'package:looks_loop/features/product_detail/presentation/widgets/product_review_card.dart';
import 'package:looks_loop/features/product_detail/presentation/widgets/product_reviews_summary.dart';
import 'package:looks_loop/features/product_detail/presentation/widgets/product_size_selector.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProductDetailBody extends StatelessWidget {
  final ProductDetailLoaded state;

  const ProductDetailBody({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailCubit>();
    final product = state.product;
    final imageUrls = product.images.map((img) => img.url).toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductGalleryCarousel(
            images: imageUrls,
            selectedIndex: state.selectedImageIndex,
            onPageChanged: cubit.selectImage,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductInfoHeader(
                  brand: product.brand,
                  name: product.name,
                  price: product.price,
                  originalPrice: product.originalPrice,
                  sku: state.selectedVariant?.sku ?? product.sku,
                  isInStock: state.isSelectedVariantAvailable,
                ),
                SizedBox(height: 20.h),
                ProductColorSelector(
                  colors: product.colors,
                  selectedColorId: state.selectedColorId,
                  onColorSelected: cubit.selectColor,
                ),
                SizedBox(height: 20.h),
                ProductSizeSelector(
                  sizes: product.sizes,
                  selectedSizeId: state.selectedSizeId,
                  isSizeAvailable: state.isSizeAvailable,
                  onSizeSelected: cubit.selectSize,
                ),
                if (product.description.trim().isNotEmpty) ...[
                  SizedBox(height: 24.h),
                  ProductDescriptionSection(description: product.description),
                ],
                if (product.materialCare.trim().isNotEmpty ||
                    product.sizeFit.trim().isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  ProductExpandableSections(
                    materialAndCare: product.materialCare,
                    sizeAndFit: product.sizeFit,
                    expandedIndex: state.expandedSectionIndex,
                    onToggle: cubit.toggleSection,
                  ),
                ],
                if (product.ratingCount > 0 || product.reviews.isNotEmpty) ...[
                  SizedBox(height: 28.h),
                  ProductReviewsSummary(
                    score: product.ratingAverage,
                    totalReviews: product.ratingCount,
                    distributions: product.ratingDistribution,
                  ),
                  SizedBox(height: 16.h),
                  ...product.reviews.map((review) {
                    return ProductReviewCard(
                      review: review,
                      isHelpful: state.helpfulReviewIds.contains(review.id),
                      onHelpfulTap: () => cubit.toggleReviewHelpful(review.id),
                    );
                  }),
                  if (product.reviews.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    _buildViewAllReviewsButton(context),
                  ],
                ],
              ],
            ),
          ),
          if (product.related.isNotEmpty) ...[
            SizedBox(height: 8.h),
            ProductRecommendedRail(
              products: product.related,
              onProductTap: (item) => context.push(
                Routes.productDetailPath(
                  item.slug.isNotEmpty ? item.slug : item.id,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildViewAllReviewsButton(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'VIEW ALL REVIEWS',
              style: TextStyles.font11Action(context).copyWith(
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              LucideIcons.arrowUpRight,
              size: 14.sp,
              color: ColorManager.getText(context),
            ),
          ],
        ),
      ),
    );
  }
}
