import 'package:equatable/equatable.dart';

/// Immutable parameter object containing all registration fields.
class RegisterParams extends Equatable {
  final String phone;
  final String password;
  final String name;
  final String? email;
  final String preferredLanguage;
  final String? gender;
  final String? birthday;
  final String? cartToken;

  const RegisterParams({
    required this.phone,
    required this.password,
    required this.name,
    this.email,
    this.preferredLanguage = 'en',
    this.gender,
    this.birthday,
    this.cartToken,
  });

  @override
  List<Object?> get props => [
        phone,
        password,
        name,
        email,
        preferredLanguage,
        gender,
        birthday,
        cartToken,
      ];
}
