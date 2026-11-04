import 'package:looks_loop/features/more/domain/entities/update_user_profile_params.dart';

class UpdateUserProfileRequestModel {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String birthday;
  final String currentPassword;

  const UpdateUserProfileRequestModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthday,
    required this.currentPassword,
  });

  factory UpdateUserProfileRequestModel.fromEntity(UpdateUserProfileParams params) {
    return UpdateUserProfileRequestModel(
      name: params.name,
      email: params.email,
      phone: params.phone,
      gender: params.gender,
      birthday: params.birthday,
      currentPassword: params.currentPassword,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
      'birthday': birthday,
      'current_password': currentPassword,
    };
  }
}

