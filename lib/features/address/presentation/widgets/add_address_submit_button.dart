import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_cubit.dart';
import 'package:looks_loop/features/address/presentation/bloc/address_state.dart';

class AddAddressSubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;

  const AddAddressSubmitButton({
    super.key,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        final isSaving = state is AddressLoaded && state.isSaving;

        return SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: isSaving ? null : onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.olive,
              foregroundColor: ColorManager.cream,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: isSaving
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: ColorManager.cream,
                    ),
                  )
                : Text(
                    'address.save_address'.tr(),
                    style: TextStyles.font14SemiBold(context).copyWith(
                      color: ColorManager.cream,
                      letterSpacing: 0.8,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
