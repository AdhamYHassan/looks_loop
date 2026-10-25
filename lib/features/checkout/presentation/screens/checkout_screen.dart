import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_cubit.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_state.dart';
import 'package:looks_loop/features/cart/domain/entities/cart_entity.dart';
import 'package:looks_loop/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:looks_loop/features/cart/presentation/bloc/cart_state.dart';
import 'package:looks_loop/features/checkout/presentation/bloc/checkout_cubit.dart';
import 'package:looks_loop/features/checkout/presentation/bloc/checkout_state.dart';
import 'package:looks_loop/features/checkout/presentation/helpers/checkout_step_helper.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_header.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_step_content.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_sticky_cta.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_success_sheet.dart';

class CheckoutScreen extends StatefulWidget {
  final CartEntity? initialCart;

  const CheckoutScreen({super.key, this.initialCart});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AddressCubit>().loadAddresses();
    context.read<AddressCubit>().loadProvinces();
    context.read<CheckoutCubit>().loadPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: BlocConsumer<CheckoutCubit, CheckoutState>(
        listenWhen: (prev, curr) =>
            prev.orderError != curr.orderError ||
            prev.placedOrder != curr.placedOrder,
        listener: (context, state) {
          if (state.orderError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.orderError!),
                backgroundColor: ColorManager.orange,
              ),
            );
          } else if (state.placedOrder != null) {
            context.read<CartCubit>().getCart();
            CheckoutSuccessSheet.show(
              context,
              orderNumber: state.placedOrder?.orderNumber ?? '',
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<CheckoutCubit>();
          final cartState = context.watch<CartCubit>().state;
          final cart =
              cartState is CartLoaded ? cartState.cart : widget.initialCart;

          final addressState = context.watch<AddressCubit>().state;
          final addresses = switch (addressState) {
            AddressLoaded(:final addresses) => addresses,
            AddressActionSuccess(:final addresses) => addresses,
            AddressError(:final addresses) => addresses,
            _ => const <AddressEntity>[],
          };

          final selectedAddress = addresses.cast<AddressEntity?>().firstWhere(
                (a) => a?.id == state.selectedAddressId,
                orElse: () => addresses.firstOrNull,
              );

          final priceText =
              CheckoutStepHelper.calculatePriceText(state, cart);

          return Scaffold(
            backgroundColor: ColorManager.getBackground(context),
            bottomNavigationBar: CheckoutStickyCta(
              label: CheckoutStepHelper.getCtaLabel(
                state.currentStep,
                isPlacingOrder: state.isPlacingOrder,
              ),
              priceText: priceText,
              isEnabled: CheckoutStepHelper.isStepEnabled(
                state,
                addresses.isNotEmpty,
              ),
              onPressed: () => CheckoutStepHelper.handleCtaPress(
                cubit: cubit,
                state: state,
                address: selectedAddress,
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  CheckoutHeader(
                    currentStep: state.currentStep,
                    onBack: () {
                      if (!cubit.previousStep()) context.pop();
                    },
                  ),
                  Expanded(
                    child: CheckoutStepContent(
                      state: state,
                      cubit: cubit,
                      selectedAddress: selectedAddress,
                      cart: cart,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
