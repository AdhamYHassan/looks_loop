import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_user_entity.dart';

class AuthUserModel extends Equatable {
  final int id;
  final String phone;
  final String phoneLocal;
  final String name;
  final String email;
  final String preferredLanguage;
  final DateTime? dateJoined;

  const AuthUserModel({
    required this.id,
    required this.phone,
    required this.phoneLocal,
    required this.name,
    required this.email,
    required this.preferredLanguage,
    this.dateJoined,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'] as int? ?? 0,
      phone: json['phone'] as String? ?? '',
      phoneLocal: json['phone_local'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      preferredLanguage: json['preferred_language'] as String? ?? 'en',
      dateJoined: json['date_joined'] != null
          ? DateTime.tryParse(json['date_joined'] as String)
          : null,
    );
  }

  AuthUserEntity toEntity() => AuthUserEntity(
        id: id,
        phone: phone,
        phoneLocal: phoneLocal,
        name: name,
        email: email,
        preferredLanguage: preferredLanguage,
        dateJoined: dateJoined,
      );

  @override
  List<Object?> get props => [
        id,
        phone,
        phoneLocal,
        name,
        email,
        preferredLanguage,
        dateJoined,
      ];
}
