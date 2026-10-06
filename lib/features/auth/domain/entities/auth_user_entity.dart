import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  final int id;
  final String phone;
  final String phoneLocal;
  final String name;
  final String email;
  final String preferredLanguage;
  final DateTime? dateJoined;

  const AuthUserEntity({
    required this.id,
    required this.phone,
    required this.phoneLocal,
    required this.name,
    required this.email,
    required this.preferredLanguage,
    this.dateJoined,
  });

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
