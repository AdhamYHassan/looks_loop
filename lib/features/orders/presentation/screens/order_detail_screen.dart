import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/app_snack_bar.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/orders/presentation/bloc/order_detail_cubit.dart';
import 'package:looks_loop/features/orders/presentation/bloc/order_detail_state.dart';
import 'package:looks_loop/features/orders/presentation/widgets/cancel_order_dialog.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_detail_content.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_detail_error_view.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_detail_skeleton_loader.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderNumber;

  const OrderDetailScreen({super.key, required this.orderNumber});

  Future<void> _onCancelPressed(BuildContext context) async {
    final confirmed = await showCancelOrderDialog(context);
    if (confirmed == true && context.mounted) {
      final success =
          await context.read<OrderDetailCubit>().cancelOrder(orderNumber);
      if (success && context.mounted) {
        AppSnackBar.showSuccess(
          context,
          message: 'orders.cancel_success'.tr(),
        );
      }
    }
  }

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
                child: BlocConsumer<OrderDetailCubit, OrderDetailState>(
                  listener: (context, state) {
                    if (state is OrderDetailLoaded &&
                        state.cancelError != null) {
                      AppSnackBar.showError(
                        context,
                        message: state.cancelError!,
                      );
                    }
                  },
                  builder: (context, state) => switch (state) {
                    OrderDetailInitial() || OrderDetailLoading() =>
                      const OrderDetailSkeletonLoader(),
                    OrderDetailError(:final message) => OrderDetailErrorView(
                        message: message,
                        onRetry: () => context
                            .read<OrderDetailCubit>()
                            .loadOrderDetail(orderNumber),
                      ),
                    OrderDetailLoaded(:final order, :final isCancelling) =>
                      RefreshIndicator(
                        color: ColorManager.olive,
                        onRefresh: () => context
                            .read<OrderDetailCubit>()
                            .loadOrderDetail(orderNumber),
                        child: OrderDetailContent(
                          order: order,
                          isCancelling: isCancelling,
                          onCancelTap: () => _onCancelPressed(context),
                        ),
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
