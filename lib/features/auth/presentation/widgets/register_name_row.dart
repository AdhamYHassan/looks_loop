import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/features/auth/presentation/widgets/register_labeled_field.dart';

/// Row containing First Name and Last Name inputs side-by-side.
class RegisterNameRow extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const RegisterNameRow({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RegisterLabeledField(
            controller: firstNameController,
            label: 'auth.first_name'.tr(),
            hintText: 'auth.first_name_hint'.tr(),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: RegisterLabeledField(
            controller: lastNameController,
            label: 'auth.last_name'.tr(),
            hintText: 'auth.last_name_hint'.tr(),
          ),
        ),
      ],
    );
  }
}
