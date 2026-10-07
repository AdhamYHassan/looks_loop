import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_tokens_entity.dart';

class AuthTokensModel extends Equatable {
  final String access;
  final String refresh;

  const AuthTokensModel({
    required this.access,
    required this.refresh,
  });

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) {
    return AuthTokensModel(
      access: json['access'] as String? ??
          json['access_token'] as String? ??
          json['token'] as String? ??
          '',
      refresh: json['refresh'] as String? ??
          json['refresh_token'] as String? ??
          '',
    );
  }

  AuthTokensEntity toEntity() => AuthTokensEntity(
        access: access,
        refresh: refresh,
      );

  @override
  List<Object?> get props => [access, refresh];
}
