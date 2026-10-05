import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String name;
  final bool isGuest;
  final String? email;

  const UserProfileEntity({
    required this.name,
    this.isGuest = true,
    this.email,
  });

  const UserProfileEntity.guest()
      : name = 'GUEST',
        isGuest = true,
        email = null;

  @override
  List<Object?> get props => [name, isGuest, email];
}
