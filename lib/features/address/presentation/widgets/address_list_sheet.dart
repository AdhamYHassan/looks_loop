import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/di/dependency_injection.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/core/widgets/loaders/look_around_eyes_loader.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_cubit.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_state.dart';
import 'package:looks_loop/features/address/presentation/widgets/address_card.dart';
import 'package:looks_loop/features/address/presentation/widgets/address_empty_view.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_sheet.dart';

class AddressListSheet extends StatelessWidget {
  const AddressListSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (_) => getIt<AddressCubit>()..loadAddresses(),
        child: const AddressListSheet(),
      ),
    );
  }

  void _openAddAddress(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<AddressCubit>(),
        child: const AddAddressSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.85;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      decoration: BoxDecoration(
        color: ColorManager.getBackground(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          const Divider(height: 1, color: ColorManager.line),
          Flexible(
            child: BlocBuilder<AddressCubit, AddressState>(
              builder: (context, state) => _buildBody(context, state),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_rounded),
          ),
          const SizedBox(width: 8),
          Text('address.title'.tr(), style: TextStyles.font18SemiBold(context)),
          const Spacer(),
          IconButton(
            onPressed: () => _openAddAddress(context),
            icon: const Icon(Icons.add_rounded, size: 26),
            tooltip: 'address.add_new'.tr(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, AddressState state) {
    return switch (state) {
      AddressLoading() || AddressInitial() => const Padding(
          padding: EdgeInsets.all(48.0),
          child: Center(child: LookAroundEyesLoader(width: 100)),
        ),
      AddressLoaded(:final addresses) when addresses.isEmpty =>
        AddressEmptyView(
          onAddAddress: () => _openAddAddress(context),
        ),
      AddressLoaded(:final addresses) => _buildAddressList(addresses),
      AddressActionSuccess(:final addresses) when addresses.isEmpty =>
        AddressEmptyView(
          onAddAddress: () => _openAddAddress(context),
        ),
      AddressActionSuccess(:final addresses) => _buildAddressList(addresses),
      AddressError(:final message) => Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: TextStyles.font14Regular(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.read<AddressCubit>().loadAddresses(),
                child: Text('common.retry'.tr()),
              ),
            ],
          ),
        ),
    };
  }

  Widget _buildAddressList(List<AddressEntity> addresses) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: addresses.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final address = addresses[index];
        return AddressCard(address: address);
      },
    );
  }
}
