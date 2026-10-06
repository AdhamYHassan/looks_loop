import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/auth/data/models/auth_tokens_model.dart';
import 'package:looks_loop/features/auth/data/models/auth_user_model.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';

class AuthResponseModel extends Equatable {
  final AuthUserModel user;
  final AuthTokensModel tokens;

  const AuthResponseModel({
    required this.user,
    required this.tokens,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: AuthUserModel.fromJson(
        json['user'] as Map<String, dynamic>? ?? {},
      ),
      tokens: AuthTokensModel.fromJson(
        json['tokens'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  AuthResponseEntity toEntity() => AuthResponseEntity(
        user: user.toEntity(),
        tokens: tokens.toEntity(),
      );

  @override
  List<Object?> get props => [user, tokens];
}
