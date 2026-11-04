import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final int id;
  final String name;
  final bool isGuest;
  final String? email;
  final String? phone;
  final String? phoneLocal;
  final String? gender;
  final String? birthday;
  final DateTime? dateJoined;

  const UserProfileEntity({
    this.id = 0,
    required this.name,
    this.isGuest = false,
    this.email,
    this.phone,
    this.phoneLocal,
    this.gender,
    this.birthday,
    this.dateJoined,
  });

  const UserProfileEntity.guest()
      : id = 0,
        name = 'GUEST',
        isGuest = true,
        email = null,
        phone = null,
        phoneLocal = null,
        gender = null,
        birthday = null,
        dateJoined = null;

  UserProfileEntity copyWith({
    int? id,
    String? name,
    bool? isGuest,
    String? email,
    String? phone,
    String? phoneLocal,
    String? gender,
    String? birthday,
    DateTime? dateJoined,
  }) {
    return UserProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isGuest: isGuest ?? this.isGuest,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      phoneLocal: phoneLocal ?? this.phoneLocal,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      dateJoined: dateJoined ?? this.dateJoined,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        isGuest,
        email,
        phone,
        phoneLocal,
        gender,
        birthday,
        dateJoined,
      ];
}
