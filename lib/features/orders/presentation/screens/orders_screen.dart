import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/home/presentation/widgets/announcement_bar.dart';
import 'package:looks_loop/features/orders/presentation/bloc/orders_cubit.dart';
import 'package:looks_loop/features/orders/presentation/bloc/orders_state.dart';
import 'package:looks_loop/features/orders/presentation/widgets/order_card.dart';
import 'package:looks_loop/features/orders/presentation/widgets/orders_empty_view.dart';
import 'package:looks_loop/features/orders/presentation/widgets/orders_skeleton_loader.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

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
                child: const SafeArea(
                  bottom: false,
                  child: AnnouncementBar(),
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
                  'orders.title'.tr(),
                  style: TextStyles.font18SemiBold(context),
                ),
              ),
              Expanded(
                child: BlocBuilder<OrdersCubit, OrdersState>(
                  builder: (context, state) => switch (state) {
                    OrdersInitial() || OrdersLoading() =>
                      const OrdersSkeletonLoader(),
                    OrdersLoaded(:final orders) when orders.isEmpty =>
                      _refreshable(
                        context,
                        const OrdersEmptyView(),
                      ),
                    OrdersLoaded(:final orders) => RefreshIndicator(
                        color: ColorManager.olive,
                        onRefresh: () =>
                            context.read<OrdersCubit>().loadOrders(),
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16),
                          itemCount: orders.length,
                          itemBuilder: (_, index) =>
                              OrderCard(order: orders[index]),
                        ),
                      ),
                    OrdersError(:final message) => _ErrorView(message: message),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _refreshable(BuildContext context, Widget child) {
    return RefreshIndicator(
      color: ColorManager.olive,
      onRefresh: () => context.read<OrdersCubit>().loadOrders(),
      child: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(height: constraints.maxHeight, child: child),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyles.font14Regular(context),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<OrdersCubit>().loadOrders(),
              child: Text('common.retry'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
