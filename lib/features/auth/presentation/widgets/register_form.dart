import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/helpers/password_validator.dart';
import 'package:looks_loop/core/widgets/app_snack_bar.dart';
import 'package:looks_loop/features/auth/domain/entities/register_params.dart';
import 'package:looks_loop/features/auth/presentation/widgets/login_submit_button.dart';
import 'package:looks_loop/features/auth/presentation/widgets/lookloops_date_picker_sheet.dart';
import 'package:looks_loop/features/auth/presentation/widgets/register_gender_selector.dart';
import 'package:looks_loop/features/auth/presentation/widgets/register_header_title.dart';
import 'package:looks_loop/features/auth/presentation/widgets/register_labeled_field.dart';
import 'package:looks_loop/features/auth/presentation/widgets/register_name_row.dart';
import 'package:looks_loop/features/auth/presentation/widgets/register_password_section.dart';
import 'package:looks_loop/features/auth/presentation/widgets/staggered_reveal.dart';

/// Form widget managing registration inputs, live password policy, and dimmed submit CTA.
class RegisterForm extends StatefulWidget {
  final void Function(RegisterParams params)? onRegister;
  final bool isLoading;

  const RegisterForm({
    super.key,
    this.onRegister,
    this.isLoading = false,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>
    with SingleTickerProviderStateMixin {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();

  PasswordValidationResult _validationResult =
      const PasswordValidationResult.initial();
  String? _rawBirthdayIso;
  String? _selectedGender;
  bool _isFormFilled = false;
  late final AnimationController _entrance;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();

    _firstNameController.addListener(_onInputsChanged);
    _lastNameController.addListener(_onInputsChanged);
    _phoneController.addListener(_onInputsChanged);
    _passwordController.addListener(_onInputsChanged);
    _confirmPasswordController.addListener(_onInputsChanged);
    _emailController.addListener(_onInputsChanged);
  }

  @override
  void dispose() {
    _entrance.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _onInputsChanged() {
    final result = PasswordValidator.validate(
      password: _passwordController.text,
      name: '${_firstNameController.text} ${_lastNameController.text}',
      phone: _phoneController.text,
      email: _emailController.text,
    );
    final filled = _firstNameController.text.trim().isNotEmpty &&
        _lastNameController.text.trim().isNotEmpty &&
        _phoneController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _selectedGender != null &&
        _selectedGender!.isNotEmpty;

    if (result != _validationResult || filled != _isFormFilled) {
      setState(() {
        _validationResult = result;
        _isFormFilled = filled;
      });
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await LookLoopsDatePickerSheet.show(
      context: context,
      initialDate: DateTime(now.year - 20, now.month, now.day),
      minimumDate: DateTime(1920),
      maximumDate: now,
    );
    if (picked != null) {
      _rawBirthdayIso =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      _dobController.text =
          '${picked.day.toString().padLeft(2, '0')} / ${picked.month.toString().padLeft(2, '0')} / ${picked.year}';
    }
  }

  String? _getValidationErrorMessage() {
    if (_phoneController.text.trim().isEmpty) {
      return 'validation.invalid_phone'.tr();
    }
    final email = _emailController.text.trim();
    if (email.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'validation.invalid_email'.tr();
    }
    if (_selectedGender == null || _selectedGender!.isEmpty) {
      return 'validation.required_field'.tr();
    }
    if (!_validationResult.notSimilarToPersonalInfo) {
      return 'auth.pwd_req_not_similar'.tr();
    }
    if (!_validationResult.hasMinLength) {
      return 'auth.pwd_req_min_8'.tr();
    }
    if (!_validationResult.notCommon) {
      return 'auth.pwd_req_not_common'.tr();
    }
    if (!_validationResult.notEntirelyNumeric) {
      return 'auth.pwd_req_not_numeric'.tr();
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      return 'auth.password_must_match'.tr();
    }
    return null;
  }

  void _submit() {
    final error = _getValidationErrorMessage();
    if (error != null) {
      AppSnackBar.showError(context, message: error);
      return;
    }

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final name = '$firstName $lastName'.trim();
    final email = _emailController.text.trim();

    widget.onRegister?.call(
      RegisterParams(
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
        name: name.isNotEmpty ? name : 'LookLoops User',
        email: email,
        gender: _selectedGender,
        birthday: _rawBirthdayIso,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const RegisterHeaderTitle(),
        SizedBox(height: 18.h),
        StaggeredReveal(
          animation: _entrance,
          index: 0,
          child: RegisterNameRow(
            firstNameController: _firstNameController,
            lastNameController: _lastNameController,
          ),
        ),
        SizedBox(height: 14.h),
        StaggeredReveal(
          animation: _entrance,
          index: 1,
          child: RegisterLabeledField(
            controller: _phoneController,
            label: 'auth.phone_number'.tr(),
            hintText: '010XXXXXXXX',
            keyboardType: TextInputType.phone,
          ),
        ),
        SizedBox(height: 14.h),
        StaggeredReveal(
          animation: _entrance,
          index: 2,
          child: RegisterPasswordSection(
            passwordController: _passwordController,
            confirmPasswordController: _confirmPasswordController,
            validationResult: _validationResult,
          ),
        ),
        SizedBox(height: 14.h),
        StaggeredReveal(
          animation: _entrance,
          index: 3,
          child: RegisterLabeledField(
            controller: _emailController,
            label: 'auth.email_label'.tr(),
            hintText: 'auth.email_hint'.tr(),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        SizedBox(height: 14.h),
        StaggeredReveal(
          animation: _entrance,
          index: 4,
          child: RegisterLabeledField(
            controller: _dobController,
            label: 'auth.date_of_birth'.tr(),
            hintText: 'auth.dob_hint'.tr(),
            isOptional: true,
            readOnly: true,
            onTap: _pickDate,
            suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
          ),
        ),
        SizedBox(height: 14.h),
        StaggeredReveal(
          animation: _entrance,
          index: 5,
          child: RegisterGenderSelector(
            selectedGender: _selectedGender,
            onGenderSelected: (gender) {
              _selectedGender = gender;
              _onInputsChanged();
            },
          ),
        ),
        SizedBox(height: 24.h),
        StaggeredReveal(
          animation: _entrance,
          index: 6,
          child: LoginSubmitButton(
            label: 'auth.continue_btn'.tr(),
            isLoading: widget.isLoading,
            onPressed: _isFormFilled ? _submit : null,
          ),
        ),
      ],
    );
  }
}
