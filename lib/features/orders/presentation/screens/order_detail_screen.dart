import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/orders/domain/entities/order_detail_entity.dart';
import 'package:looks_loop/features/orders/presentation/bloc/order_detail_cubit.dart';
import 'package:looks_loop/features/orders/presentation/bloc/order_detail_state.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_address_section.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_cancel_button.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_detail_header.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_detail_skeleton_loader.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_info_card.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_items_section.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_summary_section.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_tracking_stepper.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderNumber;

  const OrderDetailScreen({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: ColorManager.getBackground(context),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Container(
                color: ColorManager.olive,
                child: SafeArea(
                  bottom: false,
                  child: AnnouncementBar(text: 'more.easy_returns'.tr()),
                ),
              ),
              AppBar(
                primary: false,
                backgroundColor: ColorManager.getBackground(context),
                elevation: 0,
                scrolledUnderElevation: 0,
                centerTitle: false,
                leading: BackButton(
                  color: ColorManager.getText(context),
                ),
                title: Text(
                  'orders.details_title'.tr(),
                  style: TextStyles.font18SemiBold(context),
                ),
              ),
              Expanded(
                child: BlocBuilder<OrderDetailCubit, OrderDetailState>(
                  builder: (context, state) => switch (state) {
                    OrderDetailInitial() || OrderDetailLoading() =>
                      const OrderDetailSkeletonLoader(),
                    OrderDetailError(:final message) => _ErrorView(
                        message: message,
                        onRetry: () => context
                            .read<OrderDetailCubit>()
                            .loadOrderDetail(orderNumber),
                      ),
                    OrderDetailLoaded(:final order) => RefreshIndicator(
                        color: ColorManager.olive,
                        onRefresh: () => context
                            .read<OrderDetailCubit>()
                            .loadOrderDetail(orderNumber),
                        child: _DetailContent(order: order),
                      ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  final OrderDetailEntity order;

  const _DetailContent({required this.order});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderDetailHeader(order: order),
          Gap(16.h),
          OrderTrackingStepper(order: order),
          Gap(16.h),
          OrderItemsSection(items: order.items),
          Gap(16.h),
          OrderAddressSection(address: order.address),
          Gap(16.h),
          OrderInfoCard(
            title: 'orders.delivery_method'.tr(),
            primaryText: 'orders.standard_delivery'.tr(),
            secondaryText: 'orders.delivery_days'.tr(),
          ),
          Gap(16.h),
          OrderInfoCard(
            title: 'orders.payment_method'.tr(),
            primaryText: order.paymentMethodDisplay,
          ),
          Gap(16.h),
          OrderSummarySection(pricing: order.pricing),
          if (order.canCancel) ...[
            Gap(20.h),
            OrderCancelButton(
              onCancelTap: () {},
            ),
          ],
          Gap(32.h),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyles.font14Regular(context),
            ),
            Gap(16.h),
            ElevatedButton(
              onPressed: onRetry,
              child: Text('common.retry'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
