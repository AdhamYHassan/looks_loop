import 'package:looks_loop/features/more/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    super.id,
    required super.name,
    super.isGuest = false,
    super.email,
    super.phone,
    super.phoneLocal,
    super.gender,
    super.birthday,
    super.dateJoined,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDateJoined;
    if (json['date_joined'] != null) {
      parsedDateJoined = DateTime.tryParse(json['date_joined'].toString());
    }

    return UserProfileModel(
      id: json['id'] is int ? json['id'] as int : 0,
      name: json['name'] as String? ?? '',
      isGuest: false,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      phoneLocal: json['phone_local'] as String?,
      gender: json['gender'] as String?,
      birthday: json['birthday'] as String?,
      dateJoined: parsedDateJoined,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'phone_local': phoneLocal,
      'gender': gender,
      'birthday': birthday,
      'date_joined': dateJoined?.toIso8601String(),
    };
  }
}

