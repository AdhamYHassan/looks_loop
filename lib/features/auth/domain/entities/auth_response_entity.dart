import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_tokens_entity.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_user_entity.dart';

class AuthResponseEntity extends Equatable {
  final AuthUserEntity user;
  final AuthTokensEntity tokens;

  const AuthResponseEntity({
    required this.user,
    required this.tokens,
  });

  @override
  List<Object?> get props => [user, tokens];
}
