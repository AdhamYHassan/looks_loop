import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/widgets/app_snack_bar.dart';
import 'package:looks_loop/features/auth/presentation/widgets/lookloops_date_picker_sheet.dart';
import 'package:looks_loop/features/more/domain/entities/update_user_profile_params.dart';
import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';
import 'package:looks_loop/features/more/presentation/widgets/account_field_card.dart';
import 'package:looks_loop/features/more/presentation/widgets/account_gender_selector.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AccountFormContent extends StatefulWidget {
  final UserProfileEntity profile;
  final bool isUpdating;
  final ValueChanged<UpdateUserProfileParams> onSubmit;

  const AccountFormContent({
    super.key,
    required this.profile,
    required this.isUpdating,
    required this.onSubmit,
  });

  @override
  State<AccountFormContent> createState() => _AccountFormContentState();
}

class _AccountFormContentState extends State<AccountFormContent> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _birthdayController;
  late final TextEditingController _passwordController;
  late String _gender;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _emailController = TextEditingController(text: widget.profile.email ?? '');
    _phoneController = TextEditingController(text: widget.profile.phone ?? '');
    _birthdayController =
        TextEditingController(text: widget.profile.birthday ?? '');
    _passwordController = TextEditingController();
    _gender = widget.profile.gender ?? 'male';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthdayController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickBirthday() async {
    final now = DateTime.now();
    DateTime initial = DateTime(2000, 1, 1);
    if (_birthdayController.text.isNotEmpty) {
      final parsed = DateTime.tryParse(_birthdayController.text);
      if (parsed != null) initial = parsed;
    }
    final picked = await LookLoopsDatePickerSheet.show(
      context: context,
      initialDate: initial,
      minimumDate: DateTime(1920),
      maximumDate: now,
    );
    if (picked != null) {
      final formatted =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      setState(() => _birthdayController.text = formatted);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text.trim().isEmpty) {
      AppSnackBar.showError(
        context,
        message: 'account.current_password_required'.tr(),
      );
      return;
    }
    widget.onSubmit(
      UpdateUserProfileParams(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        gender: _gender,
        birthday: _birthdayController.text.trim(),
        currentPassword: _passwordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        children: [
          AccountFieldCard(
            label: 'account.full_name'.tr(),
            hintText: 'account.full_name_hint'.tr(),
            controller: _nameController,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'validation.required_field'.tr() : null,
          ),
          SizedBox(height: 14.h),
          AccountFieldCard(
            label: 'account.email'.tr(),
            hintText: 'account.email_hint'.tr(),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'validation.required_field'.tr() : null,
          ),
          SizedBox(height: 14.h),
          AccountFieldCard(
            label: 'account.phone'.tr(),
            hintText: 'account.phone_hint'.tr(),
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'validation.required_field'.tr() : null,
          ),
          SizedBox(height: 14.h),
          AccountGenderSelector(
            selectedGender: _gender,
            onGenderChanged: (g) => setState(() => _gender = g),
          ),
          SizedBox(height: 14.h),
          AccountFieldCard(
            label: 'account.birthday'.tr(),
            hintText: 'account.birthday_hint'.tr(),
            controller: _birthdayController,
            readOnly: true,
            onTap: _pickBirthday,
            suffixIcon: Icon(
              LucideIcons.calendar,
              size: 18.sp,
              color: ColorManager.olive,
            ),
          ),
          SizedBox(height: 18.h),
          AccountFieldCard(
            label: 'account.current_password'.tr(),
            hintText: 'account.current_password_hint'.tr(),
            controller: _passwordController,
            isObscure: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? LucideIcons.eyeOff : LucideIcons.eye,
                size: 18.sp,
                color: ColorManager.getTextMuted(context),
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          SizedBox(height: 28.h),
          ElevatedButton(
            onPressed: widget.isUpdating ? null : _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.olive,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: widget.isUpdating
                ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'account.save_changes'.tr(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo',
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
