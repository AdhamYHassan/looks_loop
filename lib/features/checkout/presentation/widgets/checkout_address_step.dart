import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/address/domain/entities/address_entity.dart';
import 'package:looks_loop/features/address/domain/entities/province_entity.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_cubit.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_state.dart';
import 'package:looks_loop/features/address/presentation/widgets/add_address_sheet.dart';
import 'package:looks_loop/features/address/presentation/widgets/address_skeleton_loader.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_add_address_button.dart';
import 'package:looks_loop/features/checkout/presentation/widgets/checkout_address_card.dart';

typedef OnAddressSelected = void Function(int addressId, int? provinceId);

class CheckoutAddressStep extends StatelessWidget {
  final int? selectedAddressId;
  final OnAddressSelected onSelectAddress;

  const CheckoutAddressStep({
    super.key,
    required this.selectedAddressId,
    required this.onSelectAddress,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state is AddressLoaded && state.addresses.isNotEmpty) {
          final target = selectedAddressId != null
              ? state.addresses.cast<AddressEntity?>().firstWhere(
                    (a) => a?.id == selectedAddressId,
                    orElse: () => null,
                  )
              : state.addresses.firstWhere(
                  (a) => a.isDefault,
                  orElse: () => state.addresses.first,
                );
          if (target != null) {
            final pId = target.provinceId ??
                _findProvinceId(target.cityId, state.provinces);
            onSelectAddress(target.id, pId);
          }
        }
      },
      builder: (context, state) {
        final (addresses, provinces) = switch (state) {
          AddressLoaded(:final addresses, :final provinces) => (addresses, provinces),
          AddressActionSuccess(:final addresses, :final provinces) => (addresses, provinces),
          AddressError(:final addresses, :final provinces) => (addresses, provinces),
          _ => (const <AddressEntity>[], const <ProvinceEntity>[]),
        };

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DELIVERY ADDRESS',
                style: TextStyles.font20Bold(context).copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
              Gap(16.h),
              if (state is AddressLoading && addresses.isEmpty)
                const AddressSkeletonLoader()
              else if (state is AddressError && addresses.isEmpty)
                Center(
                  child: Column(
                    children: [
                      Text(
                        state.message,
                        style: TextStyle(color: Colors.red, fontSize: 13.sp),
                      ),
                      Gap(12.h),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<AddressCubit>().loadAddresses(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              else if (addresses.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Text(
                      'No delivery addresses found. Please add one.',
                      style: TextStyles.font13MutedMedium(context),
                    ),
                  ),
                )
              else
                ...addresses.map((addr) {
                  return CheckoutAddressCard(
                    key: ValueKey(addr.id),
                    address: addr,
                    isSelected: addr.id == selectedAddressId,
                    onSelect: () => onSelectAddress(
                      addr.id,
                      _findProvinceId(addr.cityId, provinces),
                    ),
                    onEdit: () => _openAddressSheet(context, address: addr),
                  );
                }),
              Gap(12.h),
              CheckoutAddAddressButton(
                onPressed: () => _openAddressSheet(context),
              ),
              Gap(100.h),
            ],
          ),
        );
      },
    );
  }

  void _openAddressSheet(BuildContext context, {AddressEntity? address}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<AddressCubit>(),
        child: AddAddressSheet(initialAddress: address),
      ),
    );
  }

  static int? _findProvinceId(int cityId, List<ProvinceEntity> provinces) {
    if (cityId <= 0) return null;
    for (final p in provinces) {
      if (p.cities.any((c) => c.id == cityId) || p.id == cityId) return p.id;
    }
    return cityId;
  }
}
