import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/auth/domain/entities/register_params.dart';

/// DTO for serializing user registration request body.
class RegisterRequestModel extends Equatable {
  final String phone;
  final String password;
  final String name;
  final String? email;
  final String preferredLanguage;
  final String? gender;
  final String? birthday;
  final String? cartToken;

  const RegisterRequestModel({
    required this.phone,
    required this.password,
    required this.name,
    this.email,
    this.preferredLanguage = 'en',
    this.gender,
    this.birthday,
    this.cartToken,
  });

  factory RegisterRequestModel.fromDomain(RegisterParams params) {
    return RegisterRequestModel(
      phone: params.phone,
      password: params.password,
      name: params.name,
      email: params.email,
      preferredLanguage: params.preferredLanguage,
      gender: params.gender,
      birthday: params.birthday,
      cartToken: params.cartToken,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'phone': phone,
      'password': password,
      'name': name,
      'preferred_language': preferredLanguage,
    };

    if (email != null && email!.isNotEmpty) {
      map['email'] = email;
    }
    if (gender != null && gender!.isNotEmpty) {
      map['gender'] = gender;
    }
    if (birthday != null && birthday!.isNotEmpty) {
      map['birthday'] = birthday;
    }
    if (cartToken != null && cartToken!.isNotEmpty) {
      map['cart_token'] = cartToken;
    }

    return map;
  }

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
