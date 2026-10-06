import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String name;
  final bool isGuest;
  final String? email;
  final String? phone;

  const UserProfileEntity({
    required this.name,
    this.isGuest = true,
    this.email,
    this.phone,
  });

  const UserProfileEntity.guest()
      : name = 'GUEST',
        isGuest = true,
        email = null,
        phone = null;

  @override
  List<Object?> get props => [name, isGuest, email, phone];
}
