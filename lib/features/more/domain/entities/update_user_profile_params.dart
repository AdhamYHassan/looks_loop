import 'package:equatable/equatable.dart';

class UpdateUserProfileParams extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String birthday;
  final String currentPassword;

  const UpdateUserProfileParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthday,
    required this.currentPassword,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        gender,
        birthday,
        currentPassword,
      ];
}

