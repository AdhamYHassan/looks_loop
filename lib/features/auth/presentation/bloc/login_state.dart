import 'package:equatable/equatable.dart';
import 'package:looks_loop/features/auth/domain/entities/auth_response_entity.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginSuccess extends LoginState {
  final AuthResponseEntity authResponse;

  const LoginSuccess(this.authResponse);

  @override
  List<Object?> get props => [authResponse];
}

final class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);

  @override
  List<Object?> get props => [message];
}
